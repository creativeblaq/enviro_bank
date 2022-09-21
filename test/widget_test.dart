import 'package:enviro_bank/features/loan/controller/loan_controller.dart';
import 'package:enviro_bank/features/loan/model/bank_account_model.dart';
import 'package:enviro_bank/features/loan/model/loan_application_model.dart';
import 'package:enviro_bank/features/loan/model/loan_application_respose_model.dart';
import 'package:enviro_bank/features/loan/model/loan_state.dart';
import 'package:enviro_bank/features/loan/repository/loan_repo.dart';
import 'package:enviro_bank/features/loan/view/home_screen.dart';
import 'package:enviro_bank/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

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
    sut = LoanController(mockLoanRepository);
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [loanControllerProvider.overrideWithValue(sut)],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }

  createInitialWidgetsExpects() {
    expect(find.byKey(const Key('intro-bubble')), findsOneWidget);
  }

  createStartApplicationWidgetsExpects() {
    expect(find.byKey(const Key('intro-bubble')), findsOneWidget);
    expect(find.byKey(const Key('loan-form-bubble')), findsOneWidget);
  }

  createSubmittedSuccessResultWidgetsExpects() {
    expect(find.byKey(const Key('success-gif-bubble')), findsOneWidget);
    expect(find.byKey(const Key('success-msg-bubble')), findsOneWidget);
  }

  createSubmittedFailResultWidgetsExpects() {
    expect(find.byKey(const Key('fail-gif-bubble')), findsOneWidget);
  }

  testWidgets(
    "initial application bubble is displayed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      createInitialWidgetsExpects();
    },
  );

  testWidgets(
    "Apply button is tapped.",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.text("Apply"));
      await tester.pumpAndSettle(const Duration(milliseconds: 1000));
      expect(find.byKey(const Key('me-apply-bubble')), findsOneWidget);
      expect(find.byKey(const Key('start-application-message-bubble')),
          findsOneWidget);
      createStartApplicationWidgetsExpects();
    },
  );

  testWidgets(
    "Cancel button is tapped.",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.text("Apply"));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.text(Strings.cancel));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      createInitialWidgetsExpects();
    },
  );

  testWidgets(
    "Submit button is tapped with success.",
    (WidgetTester tester) async {
      sut.setState(LoanStateSuccess(
          application: loanApplication,
          applicationResponse: loanApplicationResponseSuccess));

      await tester.pumpWidget(createWidgetUnderTest());
      createSubmittedSuccessResultWidgetsExpects();
    },
  );

  testWidgets(
    "Done button is tapped after success.",
    (WidgetTester tester) async {
      sut.setState(LoanStateSuccess(
          application: loanApplication,
          applicationResponse: loanApplicationResponseSuccess));

      await tester.pumpWidget(createWidgetUnderTest());
      createSubmittedSuccessResultWidgetsExpects();

      await tester.tap(find.byKey(const Key("done-btn")));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      createInitialWidgetsExpects();
    },
  );

  testWidgets(
    "apply button is tapped with fail.",
    (WidgetTester tester) async {
      sut.setState(LoanStateFail(
          application: loanApplication,
          applicationResponse: loanApplicationResponseFail));

      await tester.pumpWidget(createWidgetUnderTest());
      createSubmittedFailResultWidgetsExpects();
    },
  );

  testWidgets(
    "try again button is tapped after fail.",
    (WidgetTester tester) async {
      sut.setState(LoanStateFail(
          application: loanApplication,
          applicationResponse: loanApplicationResponseFail));
      await tester.pumpWidget(createWidgetUnderTest());
      createSubmittedFailResultWidgetsExpects();

      await tester.tap(find.byKey(const Key("retry-btn")));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byKey(const Key('fail-gif-bubble')), findsNothing);
    },
  );
}
