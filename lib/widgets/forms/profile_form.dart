import 'package:enviro_bank/features/authentication/repository/auth_repo.dart';
import 'package:enviro_bank/utils/constants.dart';
import 'package:enviro_bank/widgets/forms/default_text_field.dart';
import 'package:enviro_bank/widgets/forms/form_template.dart';
import 'package:enviro_bank/widgets/forms/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///Used to display the profile form to the user

class ProfileForm extends ConsumerWidget {
  const ProfileForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final Function(GlobalKey<FormBuilderState>) onSubmit;

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(authRepositoryProvider).user;
    return FormTemplate(
      formFields: (form) => [
        DefaultTextField(
          name: Strings.emailField,
          prefixIcon: Icons.email,
          isOutlineBorder: true,
          enabled: user == null,
          initialValue: user?.emailAddress ?? "",
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
          updateEmail: () {},
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
        DefaultTextField(
          name: Strings.confirmPasswordField,
          prefixIcon: Icons.lock,
          isOutlineBorder: true,
          hint: Strings.confirmPasswordField,
          obscureText: true,
          inputAction: TextInputAction.done,
          inputType: TextInputType.text,
          enabled: true,
          updateEmail: () {},
          validators: [
            FormBuilderValidators.required(),
            (text) {
              final pass = Forms.getFormField(form, Strings.passwordField);
              if (pass != text) {
                return Strings.errorPasswordMatch;
              } else {
                return null;
              }
            }
          ],
        ),
      ],
      formTitle: "Update Password",
      onSubmit: onSubmit,
      btnRadius: 12,
    );
  }
}
