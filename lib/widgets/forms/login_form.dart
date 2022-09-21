import 'package:awesome_flutter_extensions/all.dart';
import 'package:enviro_bank/utils/app_routes.dart';
import 'package:enviro_bank/utils/constants.dart';
import 'package:enviro_bank/widgets/forms/default_text_field.dart';
import 'package:enviro_bank/widgets/forms/form_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final Function(GlobalKey<FormBuilderState>) onSubmit;

  @override
  Widget build(BuildContext context) {
    return FormTemplate(
      formFields: (form) => [
        DefaultTextField(
          name: Strings.emailField,
          prefixIcon: Icons.email,
          isOutlineBorder: true,
          hint: Strings.emailHint,
          textCapitilization: TextCapitalization.none,
          inputAction: TextInputAction.next,
          inputType: TextInputType.emailAddress,
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ],
        ),
        DefaultTextField(
          name: Strings.passwordField,
          prefixIcon: Icons.lock,
          isOutlineBorder: true,
          hint: Strings.passwordField,
          obscureText: true,
          inputAction: TextInputAction.done,
          inputType: TextInputType.text,
          enabled: true,
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.match(
              Strings.passwordPattern,
              errorText: Strings.errorPassword,
            ),
            FormBuilderValidators.minLength(8,
                errorText: Strings.errorPassword),
          ],
        ),
        InkWell(
          onTap: () {
            context.goNamed(AppRoutes.PROFILE_SCREEN_NAME,
                queryParams: {"from": AppRoutes.LOGIN_SCREEN});
          },
          child: Container(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                text: Strings.forgotPass,
                style: context.bodyText1.copyWith(
                  color: context.iconTheme.color?.withOpacity(0.6),
                ),
              ),
            ),
          ),
        )
      ],
      formTitle: Strings.signIn,
      onSubmit: (form) => onSubmit(form),
    );
    /* return SHFormTemplate(
      form: SHForms.loginForm,
      onSubmit: onSubmit,
      formTitle: Strings.signIn,
      formFields: FormConstants.loginTextFields,
      btnRadius: 12.0,
    ); */
  }
}
