// ignore_for_file: non_constant_identifier_names

import 'package:enviro_bank/features/authentication/controller/auth_controller.dart';
import 'package:enviro_bank/features/authentication/model/auth_state.dart';
import 'package:enviro_bank/features/authentication/view/login_screen.dart';
import 'package:enviro_bank/features/authentication/view/profile_edit.dart';
import 'package:enviro_bank/features/authentication/view/register_screen.dart';
import 'package:enviro_bank/features/authentication/view/splash_screen.dart';
import 'package:enviro_bank/features/loan/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    initialLocation: AppRoutes.SPLASH_SCREEN,
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: router._redirectLogic,
    routes: AppRoutes.routes,
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(
      authControllerProvider,
      (_, __) => notifyListeners(),
    );
  }

  //redirect the user based on the auth state
  String? _redirectLogic(GoRouterState state) {
    final authState = _ref.read(authControllerProvider);

    if (state.location == AppRoutes.SPLASH_SCREEN) {
      return null;
    }
    if (state.location.contains(AppRoutes.PROFILE_SCREEN)) {
      return null;
    }

    final loggedIn = authState is AuthStateSuccess;
    final loggingIn = state.location == AppRoutes.LOGIN_SCREEN ||
        state.location == AppRoutes.REGISTRATION_SCREEN;

    if (!loggedIn) {
      return loggingIn ? null : AppRoutes.LOGIN_SCREEN;
    }

    if (loggingIn) return AppRoutes.HOME_SCREEN;

    return null;
  }
}

class AppRoutes {
  static String LOGIN_SCREEN = "/login";
  static String SPLASH_SCREEN = "/splash";
  static String PROFILE_SCREEN = "/profile";
  static String PROFILE_SCREEN_NAME = "profile";
  static String REGISTRATION_SCREEN = "/register";
  static String HOME_SCREEN = "/";

  static List<GoRoute> routes = <GoRoute>[
    GoRoute(
      path: SPLASH_SCREEN,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: HOME_SCREEN,
      name: "home",
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: PROFILE_SCREEN,
      name: "profile",
      builder: (BuildContext context, GoRouterState state) {
        final String prev = state.queryParams["from"] ?? "";
        return ProfileScreen(prev);
      },
    ),
    GoRoute(
      path: LOGIN_SCREEN,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: REGISTRATION_SCREEN,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),
  ];
}
