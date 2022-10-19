import 'package:awesome_flutter_extensions/all.dart';
import 'package:enviro_bank/utils/constants.dart';
import 'package:enviro_bank/widgets/forms/default_text_field.dart';
import 'package:enviro_bank/widgets/forms/form_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class LoanApplicationForm extends StatefulWidget {
  const LoanApplicationForm({
    Key? key,
    required this.onSubmit,
    required this.enabled,
  }) : super(key: key);

  final Function(GlobalKey<FormBuilderState>) onSubmit;
  final bool enabled;

  @override
  State<LoanApplicationForm> createState() => _LoanApplicationFormState();
}

class _LoanApplicationFormState extends State<LoanApplicationForm> {
  @override
  Widget build(BuildContext context) {
    return FormTemplate(
      formEnabled: widget.enabled,
      formFields: (form) => [
        DefaultTextField(
          name: Strings.nameField,
          //prefixIcon: Icons.email,
          isOutlineBorder: false,
          hint: Strings.nameHint,
          textCapitilization: TextCapitalization.none,
          inputAction: TextInputAction.next,
          inputType: TextInputType.text,
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.match(Strings.namePattern,
                errorText: Strings.errorInvalidName),
          ],
        ),
        DefaultTextField(
          name: Strings.surnameField,
          //prefixIcon: Icons.email,
          isOutlineBorder: false,
          hint: Strings.surnameHint,
          textCapitilization: TextCapitalization.none,
          inputAction: TextInputAction.next,
          inputType: TextInputType.text,

          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.match(Strings.namePattern,
                errorText: Strings.errorInvalidSurname),
          ],
        ),
        DefaultTextField(
          name: Strings.idNumberField,
          //prefixIcon: Icons.email,
          isOutlineBorder: false,
          hint: "123456789123",
          textCapitilization: TextCapitalization.none,
          inputAction: TextInputAction.next,
          inputType: TextInputType.number,
          maxLengthEnforced: true,
          enabled: widget.enabled,

          maxLength: 13,
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(13),
            FormBuilderValidators.maxLength(13),
            FormBuilderValidators.numeric(),
          ],
        ),
        DefaultTextField(
          name: Strings.accountNumberField,
          //prefixIcon: Icons.email,
          isOutlineBorder: false,
          hint: "1234567890",
          textCapitilization: TextCapitalization.none,
          inputAction: TextInputAction.next,
          inputType: TextInputType.number,
          maxLengthEnforced: true,
          maxLength: 10,
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(10),
            FormBuilderValidators.maxLength(10),
            FormBuilderValidators.numeric(),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBuilderDropdown<String>(
              name: Strings.bankNameField,
              dropdownColor: context.primaryColorLight,
              borderRadius: BorderRadius.circular(16),
              decoration: InputDecoration(
                labelText: Strings.bankNameField,
                labelStyle: context.bodyText1,
                hintStyle: context.bodyText1.copyWith(
                    color: context.colorScheme.onPrimary.withOpacity(0.6)),
                errorStyle: context.bodyText1
                    .copyWith(color: context.colorScheme.error, fontSize: 10),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: context.colorScheme.error)),
                hintText: 'Select Bank',
                errorMaxLines: 2,
                isCollapsed: false,
                isDense: false,
                counter: const SizedBox.shrink(),
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a bank.";
                }
                return null;
              },
              style: context.bodyText1,
              items: bankOptions
                  .map((bank) => DropdownMenuItem(
                        alignment: AlignmentDirectional.centerStart,
                        value: bank,
                        child: Text(bank),
                      ))
                  .toList(),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        DefaultTextField(
          name: Strings.branchCodeField,
          //prefixIcon: Icons.email,
          isOutlineBorder: false,
          hint: "250060",
          textCapitilization: TextCapitalization.none,
          inputAction: TextInputAction.next,
          inputType: TextInputType.number,
          maxLengthEnforced: true,
          maxLength: 6,
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(6),
            FormBuilderValidators.maxLength(6),
            FormBuilderValidators.numeric(),
          ],
        ),
        DefaultDateInputField(
            name: Strings.collectionDateField,
            hint: Strings.collectionDayHint,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365 * 100))),
        DefaultTextField(
          name: Strings.loanAmountField,
          //prefixIcon: Icons.email,
          isOutlineBorder: false,
          hint: "10000",
          prefixText: "R ",
          textCapitilization: TextCapitalization.none,
          inputAction: TextInputAction.next,
          inputType: TextInputType.number,
          maxLengthEnforced: true,
          maxLength: 10,
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
          ],
        ),
      ],
      formTitle: Strings.submit,
      btnRadius: 12,
      onSubmit: (form) => widget.onSubmit(form),
    );
  }
}

class DefaultDateInputField extends StatelessWidget {
  const DefaultDateInputField({
    Key? key,
    required this.name,
    required this.hint,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  }) : super(key: key);

  final String name;
  final String hint;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: context.colorScheme.copyWith(
          primary: context.colorScheme.secondary,
          surface: context.colorScheme.secondary,
          onPrimary: context.colorScheme.onPrimary, // selected text color
          onSurface: context.colorScheme.onSurface,
          //onSurface: Colors.amber,
        ),
        dialogBackgroundColor: context.primaryColorLight,
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      child: FormBuilderDateTimePicker(
        name: name,
        initialEntryMode: DatePickerEntryMode.calendar,
        //initialValue: DateTime.now(),
        validator: (value) {
          if (value == null) {
            return Strings.errorRequired;
          }
          return null;
        },
        onChanged: (value) {},
        inputType: InputType.date,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        currentDate: DateTime.now(),
        format: DateFormat("y/M/d"),
        style: context.bodyText1,
        decoration: InputDecoration(
          labelText: name,
          hintText: hint,
          labelStyle: context.bodyText1,
          errorStyle: context.bodyText1
              .copyWith(color: context.colorScheme.error, fontSize: 10),
          alignLabelWithHint: true,
          isCollapsed: false,
          isDense: false,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: context.bodyText1
              .copyWith(color: context.colorScheme.onPrimary.withOpacity(0.6)),
          suffixIcon: Icon(
            Icons.calendar_month,
            color: context.iconTheme.color?.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
