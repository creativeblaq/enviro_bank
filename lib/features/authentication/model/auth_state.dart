import 'package:enviro_bank/features/loan/model/loan_application_model.dart';
import 'package:equatable/equatable.dart';

/* class AuthState {
  final bool? success;
  final bool loading;
  final String? jwtToken;
  final dynamic response;
  final User? user;

  AuthState(
      {this.jwtToken,
      this.success,
      this.loading = false,
      this.response,
      this.user});

  factory AuthState.loading() {
    return AuthState(loading: true);
  }
  factory AuthState.success({required String jwtToken, required User user}) {
    return AuthState(
        loading: false, success: true, jwtToken: jwtToken, user: user);
  }
  factory AuthState.error({required dynamic error}) {
    return AuthState(loading: false, success: false, response: error);
  }

  @override
  String toString() {
    return 'AuthState(success: $success, loading: $loading, response: $response, user: $user)';
  }
} */

class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthStateInitial extends AuthState {
  const AuthStateInitial();
  @override
  List<Object?> get props => [];
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
  @override
  List<Object?> get props => [];
}

class AuthStateSuccess extends AuthState {
  final String jwtToken;
  const AuthStateSuccess({required this.jwtToken});
  @override
  List<Object?> get props => [jwtToken];
}

class AuthStateFail extends AuthState {
  final ValidationResponse response;

  const AuthStateFail({required this.response});
  @override
  List<Object?> get props => [response];
}

class AuthStateError extends AuthState {
  final String error;

  const AuthStateError({required this.error});
  @override
  List<Object?> get props => [error];
}
