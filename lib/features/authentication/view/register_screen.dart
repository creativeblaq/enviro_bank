import 'package:awesome_flutter_extensions/all.dart' hide NavigatorX;
import 'package:enviro_bank/features/authentication/controller/auth_controller.dart';
import 'package:enviro_bank/features/authentication/model/auth_state.dart';
import 'package:enviro_bank/features/loan/model/loan_application_model.dart';
import 'package:enviro_bank/utils/app_routes.dart';
import 'package:enviro_bank/utils/constants.dart';
import 'package:enviro_bank/widgets/forms/forms.dart';
import 'package:enviro_bank/widgets/forms/reg_form.dart';
import 'package:enviro_bank/widgets/glassish_container.dart';
import 'package:enviro_bank/widgets/snack_response.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      //print(next);

      if (next is AuthStateFail) {
        final res = next.props[0] as ValidationResponse;
        //  print(res);

        if (res.success == false) {
          //print(res);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (res.errors.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackResponse.error(
                context: context,
                message: res.errors.toString(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackResponse.warning(
                context: context,
                message: res.warnings.toString(),
              ),
            );
          }
        }
      }
    });

    return WillPopScope(
      onWillPop: () {
        context.go(AppRoutes.LOGIN_SCREEN);
        return Future.value(true);
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () => context.go(AppRoutes.LOGIN_SCREEN),
              icon: const Icon(Icons.chevron_left)),
        ),
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: context.height,
              width: context.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Strings.signUp,
                    style: context.h5,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GlassishContainer(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 24.0, bottom: 8.0, left: 8, right: 8),
                      child: RegistrationForm(onSubmit: (form) async {
                        await ref
                            .read(authControllerProvider.notifier)
                            .register(
                              User(
                                Forms.getFormField(form, Strings.emailField),
                                Forms.getFormField(form, Strings.passwordField),
                              ),
                            );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      context.go(AppRoutes.LOGIN_SCREEN);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RichText(
                        text: TextSpan(
                          text: Strings.alreadyHaveAccount,
                          style: context.subtitle2.copyWith(
                              color:
                                  context.subtitle2.color?.withOpacity(0.6) ??
                                      Colors.white60),
                          children: [
                            TextSpan(
                              text: " ${Strings.signIn} here",
                              style: context.subtitle2.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}