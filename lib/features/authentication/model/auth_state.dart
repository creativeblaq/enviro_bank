import 'package:enviro_bank/features/authentication/model/validation_respnse_model.dart';
import 'package:equatable/equatable.dart';

///this file contains the different auth states the app can be in

//Default auth state
class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

//initial auth state
class AuthStateInitial extends AuthState {
  const AuthStateInitial();
  @override
  List<Object?> get props => [];
}

//state when loading auth request
class AuthStateLoading extends AuthState {
  const AuthStateLoading();
  @override
  List<Object?> get props => [];
}

//successful authentication state
class AuthStateSuccess extends AuthState {
  final String jwtToken;
  const AuthStateSuccess({required this.jwtToken});
  @override
  List<Object?> get props => [jwtToken];
}

//unsuccessful authentication state with server response
class AuthStateFail extends AuthState {
  final ValidationResponse response;

  const AuthStateFail({required this.response});
  @override
  List<Object?> get props => [response];
}

//unsuccessful authentication state with unknown error
class AuthStateError extends AuthState {
  final String error;

  const AuthStateError({required this.error});
  @override
  List<Object?> get props => [error];
}
