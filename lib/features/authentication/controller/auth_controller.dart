import 'package:enviro_bank/features/authentication/model/auth_state.dart';
import 'package:enviro_bank/features/authentication/model/user_model.dart';
import 'package:enviro_bank/features/authentication/model/validation_respnse_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:enviro_bank/features/authentication/repository/auth_repo.dart';

///manages the auth state for the application
class AuthController extends StateNotifier<AuthState> {
  AuthController(this.ref) : super(const AuthState());

  final Ref ref;
  String token = "";

  //log the user in, set the token and update auth state.
  Future<void> login(User user) async {
    state = const AuthStateLoading();
    try {
      token = await ref.read(authRepositoryProvider).login(user);
      //set state to successful on successful login and provide the jwt token
      state = AuthStateSuccess(
        jwtToken: token,
      );
    } on ValidationResponse catch (e) {
      //set state to fail on failed login and provide the server error
      state = AuthStateFail(response: e);
    } catch (e) {
      //set state to Error on failed login and provide the error
      state = AuthStateError(error: e.toString());
    }
  }

  //register the user, log them in, set the token and update auth state.
  Future<void> register(User user) async {
    state = const AuthStateLoading();
    try {
      final token = await ref.read(authRepositoryProvider).register(user);
      //set state to successful on successful registration and provide the jwt token
      state = AuthStateSuccess(
        jwtToken: token,
      );
    } on ValidationResponse catch (e) {
      //set state to fail on failed registration and provide the server error
      state = AuthStateFail(response: e);
    } catch (e) {
      //set state to Error on failed registration and provide the error
      state = AuthStateError(error: e.toString());
    }
  }

  //update user password
  Future<void> updatePassword(User user) async {
    state = const AuthStateLoading();
    try {
      await ref.read(authRepositoryProvider).updatePassword(user);

      await login(user);
    } on ValidationResponse catch (e) {
      state = AuthStateFail(response: e);
    } catch (e) {
      state = AuthStateError(error: e.toString());
    }
  }

//get the currently logged in user
  User? getUser() {
    return ref.read(authRepositoryProvider).user;
  }

//logout the user
  void logout() {
    token = "";
    ref.read(authRepositoryProvider).logout();
    state = const AuthStateInitial();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});
