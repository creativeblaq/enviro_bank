import 'package:enviro_bank/features/loan/controller/loan_controller.dart';
import 'package:enviro_bank/features/loan/model/bank_account_model.dart';
import 'package:enviro_bank/features/loan/model/custom_exception_model.dart';
import 'package:enviro_bank/features/loan/model/loan_application_model.dart';
import 'package:enviro_bank/features/loan/model/loan_application_respose_model.dart';
import 'package:enviro_bank/features/loan/model/loan_state.dart';
import 'package:enviro_bank/features/loan/repository/loan_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

class MockLoanRepository extends Mock implements LoanRepository {
  @override
  String get token => "token";
}

class MockLoanRepositoryNoToken extends Mock implements LoanRepository {
  @override
  String get token => " ";
}

void main() {
  late LoanController sut;
  late MockLoanRepository mockLoanRepository;
  late MockLoanRepositoryNoToken mockLoanRepositoryNoToken;

  final loanApplication = LoanApplication(
    5000.0,
    BankAccount("2060505509", "ABSA", "200023"),
    "2022-09-30",
    "John",
    "Doe",
    "9701110000865",
  );

  final loanApplicationResponseSuccess =
      LoanApplicationResponse(true, [], [], "reference");

  final loanApplicationResponseFail =
      LoanApplicationResponse(false, [], [], "reference");

  setUp(() {
    mockLoanRepository = MockLoanRepository();
    mockLoanRepositoryNoToken = MockLoanRepositoryNoToken();
    sut = LoanController(mockLoanRepository);
  });

  stateNotifierTest<LoanController, LoanState>(
    'Emits [] when no methods are called',
    build: () => sut,
    actions: (_) {},
    expect: () => [],
  );

  group('loan repo tests', () {
    test(
      "applies using the loan repo",
      () async {
        when(() => mockLoanRepository.apply(loanApplication)).thenAnswer(
          (invocation) async {
            return loanApplicationResponseSuccess;
          },
        );
        await sut.apply(loanApplication);
        verify(() => mockLoanRepository.apply(loanApplication)).called(1);
      },
    );
  });

  group('loan application notifier tests', () {
    stateNotifierTest<LoanController, LoanState>(
      'Emits [LoanStateLoading,LoanStateSuccessful] when application is successful',
      // Arrange - create notifier
      build: () => sut,
      // Arrange - set up dependencies
      setUp: () async {
        when(() => mockLoanRepository.apply(loanApplication)).thenAnswer(
          (invocation) async {
            return loanApplicationResponseSuccess;
          },
        );
      },
      // Act - call the methods
      actions: (LoanController stateNotifier) async {
        await stateNotifier.apply(loanApplication);
      },
      // Assert
      expect: () => [
        const LoanStateLoading(),
        LoanStateSuccess(
            application: loanApplication,
            applicationResponse: loanApplicationResponseSuccess),
      ],
    );

    stateNotifierTest<LoanController, LoanState>(
      'Emits [LoanStateLoading,LoanStateFail] when application is unsuccessful',
      // Arrange - create notifier
      build: () => sut,
      // Arrange - set up dependencies
      setUp: () async {
        when(() => mockLoanRepository.apply(loanApplication)).thenAnswer(
          (invocation) async {
            return loanApplicationResponseFail;
          },
        );
      },
      // Act - call the methods
      actions: (LoanController stateNotifier) async {
        await stateNotifier.apply(loanApplication);
      },
      // Assert
      expect: () => [
        const LoanStateLoading(),
        LoanStateFail(
            application: loanApplication,
            applicationResponse: loanApplicationResponseFail),
      ],
    );

    stateNotifierTest<LoanController, LoanState>(
      'Emits [LoanStateLoading,LoanStateError] when error is returned',
      // Arrange - create notifier
      build: () => sut,
      // Arrange - set up dependencies
      setUp: () async {
        when(() => mockLoanRepository.apply(loanApplication)).thenAnswer(
          (invocation) async {
            throw CustomException('UNKNOWN_ERR', "Error");
          },
        );
      },
      // Act - call the methods
      actions: (LoanController stateNotifier) async {
        await stateNotifier.apply(loanApplication);
      },
      // Assert
      expect: () => [
        const LoanStateLoading(),
        const LoanStateError(error: "Error"),
      ],
    );

    stateNotifierTest<LoanController, LoanState>(
      'Emits [LoanStateLoading,LoanStateError] when no token is provided',
      // Arrange - create notifier
      build: () => LoanController(mockLoanRepositoryNoToken),
      // Arrange - set up dependencies
      setUp: () async {
        when(() => mockLoanRepositoryNoToken.apply(loanApplication)).thenAnswer(
          (invocation) async {
            throw CustomException('INVALID_TOKEN_ERR', "No token provided");
          },
        );
      },
      // Act - call the methods
      actions: (LoanController stateNotifier) async {
        await stateNotifier.apply(loanApplication);
      },
      // Assert
      expect: () => [
        const LoanStateLoading(),
        const LoanStateError(error: "No token provided"),
      ],
    );
  });
}
