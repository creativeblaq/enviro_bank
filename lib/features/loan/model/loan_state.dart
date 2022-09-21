import 'package:enviro_bank/features/loan/model/loan_application_model.dart';
import 'package:enviro_bank/features/loan/model/loan_application_respose_model.dart';
import 'package:equatable/equatable.dart';

class LoanState extends Equatable {
  const LoanState();
  @override
  List<Object?> get props => [];
}

class LoanStateInitial extends LoanState {
  const LoanStateInitial();
  @override
  List<Object?> get props => [];
}

class LoanStateLoading extends LoanState {
  const LoanStateLoading();
  @override
  List<Object?> get props => [];
}

class LoanStateSuccess extends LoanState {
  final LoanApplication application;
  final LoanApplicationResponse applicationResponse;

  const LoanStateSuccess(
      {required this.application, required this.applicationResponse});
  @override
  List<Object?> get props => [application, applicationResponse];
}

class LoanStateFail extends LoanState {
  final LoanApplication application;
  final LoanApplicationResponse applicationResponse;

  const LoanStateFail(
      {required this.application, required this.applicationResponse});
  @override
  List<Object?> get props => [application, applicationResponse];
}

class LoanStateError extends LoanState {
  final String error;

  const LoanStateError({required this.error});
  @override
  List<Object?> get props => [error];
}
