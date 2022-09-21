import 'package:enviro_bank/features/authentication/model/auth_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:enviro_bank/features/authentication/repository/auth_repo.dart';
import 'package:enviro_bank/features/loan/model/loan_application_model.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(this.ref) : super(const AuthState());

  final Ref ref;
  String token = "";

  Future<void> login(User user) async {
    state = const AuthStateLoading();
    try {
      token = await ref.read(authRepositoryProvider).login(user);
      state = AuthStateSuccess(
        jwtToken: token,
      );
      //return true;
    } on ValidationResponse catch (e) {
      state = AuthStateFail(response: e);

      //return false;
    } catch (e) {
      state = AuthStateError(error: e.toString());
    }
  }

  Future<void> register(User user) async {
    state = const AuthStateLoading();
    try {
      final token = await ref.read(authRepositoryProvider).register(user);
      state = AuthStateSuccess(
        jwtToken: token,
      );
    } on ValidationResponse catch (e) {
      state = AuthStateFail(response: e);
      //return false;
    } catch (e) {
      state = AuthStateError(error: e.toString());
    }
  }

  Future<void> updatePassword(User user) async {
    state = const AuthStateLoading();
    try {
      await ref.read(authRepositoryProvider).updatePassword(user);
      state = AuthStateSuccess(
        jwtToken: token,
      );
      //return true;
    } on ValidationResponse catch (e) {
      state = AuthStateFail(response: e);

      //return false;
    } catch (e) {
      state = AuthStateError(error: e.toString());
    }
  }

  User? getUser() {
    return ref.read(authRepositoryProvider).user;
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});
