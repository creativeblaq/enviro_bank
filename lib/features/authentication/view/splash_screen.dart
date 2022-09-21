import 'dart:async';

import 'package:awesome_flutter_extensions/all.dart';
import 'package:enviro_bank/utils/app_routes.dart';
import 'package:enviro_bank/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      //shoe the splash screen for 3 seconds then navigate to the login screen
      Timer(
        const Duration(seconds: 3),
        () => context.go(AppRoutes.LOGIN_SCREEN),
      );
      return null;
    }, []);
    return Scaffold(
      body: Container(
          height: context.height,
          width: context.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                //colorFilter: ColorFilter.mode(SHColors.primaryVariant.withOpacity(0.6), BlendMode.darken),
                image: AssetImage(
                  Strings.BgImage,
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enviro Bank',
                style: context.h4.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: LinearProgressIndicator(
                  color: context.colorScheme.secondary,
                ),
              ),
            ],
          )),
    );
  }
}
