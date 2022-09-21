import 'package:enviro_bank/features/loan/model/loan_state.dart';
import 'package:enviro_bank/features/loan/repository/loan_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:enviro_bank/features/loan/model/loan_application_model.dart';

class LoanController extends StateNotifier<LoanState> {
  LoanController(this.loanRepositoryProvider) : super(const LoanStateInitial());

  final LoanRepository loanRepositoryProvider;

  Future<void> apply(LoanApplication loanApplication) async {
    state = const LoanStateLoading();
    try {
      final res = await loanRepositoryProvider.apply(loanApplication);
      if (res.approved) {
        state = LoanStateSuccess(
          applicationResponse: res,
          application: loanApplication,
        );
      } else {
        state = LoanStateFail(
          applicationResponse: res,
          application: loanApplication,
        );
      }
      //return true;
    } on CustomException catch (e) {
      state = LoanStateError(error: e.message ?? e.errorCode);
    }
  }

  void resetState() {
    state = const LoanStateInitial();
  }

  setState(LoanState loanState) {
    state = loanState;
  }

  getState() {
    return state;
  }
}

final loanControllerProvider =
    StateNotifierProvider<LoanController, LoanState>((ref) {
  return LoanController(ref.read(loanRepositoryProvider));
});
