import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField({
    Key? key,
    required this.name,
    required this.hint,
    required this.validators,
    this.initialValue,
    this.maxLength = 81,
    this.maxLengthEnforced = false,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.softkeyDistance = 90.0,
    this.textCapitilization = TextCapitalization.words,
    this.obscureText = false,
    this.updateEmail,
    this.prefixIcon,
    this.suffixIcon,
    this.isOutlineBorder = false,
    this.borderRadius = 12,
    this.noBorder = false,
    this.onUpdate,
    this.autofocus = false,
    this.onSubmit,
    this.prefixText,
  }) : super(key: key);

  final String name;
  final String hint;
  final List<String? Function(String?)> validators;
  final String? initialValue;
  final int maxLength;
  final bool maxLengthEnforced;
  final int? maxLines;
  final bool enabled;
  final bool readOnly;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final dynamic prefixIcon;
  final String? prefixText;
  final dynamic suffixIcon;
  final bool obscureText;
  final Function()? updateEmail;
  final Function(String? text)? onUpdate;
  final double softkeyDistance;
  final TextCapitalization textCapitilization;
  final bool isOutlineBorder;
  final double borderRadius;
  final bool noBorder;
  final bool autofocus;
  final Function(String? val)? onSubmit;

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  dynamic prefixIcon;
  dynamic suffix;
  late Map<String, String> validationMsgs;
  late TextInputAction textInputAction;
  late TextInputType keyboardType;
  late bool obscureText;
  late bool readonly;
  int? maxLength;
  late bool isPasswordVisible;
  late double softkeyDistance;

  @override
  void initState() {
    textInputAction = widget.inputAction;
    keyboardType = widget.inputType;
    maxLength = widget.maxLength;
    obscureText = widget.obscureText;
    isPasswordVisible = widget.obscureText;
    readonly = widget.readOnly;
    prefixIcon = widget.prefixIcon;
    suffix = widget.suffixIcon;
    softkeyDistance = widget.softkeyDistance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final border = widget.noBorder
        ? InputBorder.none
        : widget.isOutlineBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )
            : const UnderlineInputBorder();

    return Container(
      margin: const EdgeInsets.only(bottom: 6.0, top: 4),
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: widget.name,
        scrollPadding: EdgeInsets.all(softkeyDistance),
        decoration: InputDecoration(
          labelText: widget.name,
          labelStyle: context.bodyText1,
          hintStyle: context.bodyText1
              .copyWith(color: context.colorScheme.onPrimary.withOpacity(0.6)),
          hintText: widget.hint,
          errorStyle: context.bodyText1
              .copyWith(color: context.colorScheme.error, fontSize: 10),
          errorBorder: border.copyWith(
            borderSide: BorderSide(
              color: context.colorScheme.error,
            ),
          ),
          errorMaxLines: 2,
          isCollapsed: false,
          isDense: false,
          counter: const SizedBox.shrink(),
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: border.copyWith(
              borderSide: BorderSide(color: context.colorScheme.secondary)),
          border: border.copyWith(
              borderSide: BorderSide(color: context.colorScheme.secondary)),
          disabledBorder: border.copyWith(
              borderSide: BorderSide(color: context.primaryColorLight)),
          enabledBorder: border.copyWith(
              borderSide: BorderSide(color: context.primaryColorLight)),
          focusColor: context.colorScheme.secondary,
          floatingLabelStyle: context.bodyText1
              .copyWith(fontSize: 10, color: context.iconTheme.color),
          enabled: widget.enabled,
          prefixText: widget.prefixText,
          prefixStyle: context.bodyText1
              .copyWith(color: context.colorScheme.onPrimary.withOpacity(0.6)),
          prefixIcon: obscureText && prefixIcon != null
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: isPasswordVisible
                      ? Icon(Icons.visibility_off_outlined,
                          color: context.iconTheme.color)
                      : Icon(Icons.visibility_outlined,
                          color: context.iconTheme.color),
                )
              : prefixIcon == null
                  ? null
                  : (prefixIcon is IconData
                      ? Icon(
                          prefixIcon as IconData,
                          color: context.iconTheme.color,
                        )
                      : prefixIcon),
          suffixIcon: (suffix is IconData
                  ? Icon(
                      suffix as IconData,
                      color: context.iconTheme.color,
                    )
                  : suffix) ??
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    obscureText && prefixIcon == null
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: isPasswordVisible
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(
                                    Icons.visibility_outlined,
                                  ),
                            color: context.iconTheme.color,
                            //iconColor: context.colorScheme.primaryLight
                          )
                        : const SizedBox.shrink(),
                    readonly && widget.updateEmail != null
                        ? IconButton(
                            onPressed: widget.updateEmail,
                            icon: const Icon(Icons.edit),
                            color: context.iconTheme.color,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
        ),
        cursorColor: context.colorScheme.secondary,
        enabled: widget.enabled,
        readOnly: readonly,
        maxLength: widget.maxLength,
        textCapitalization: widget.textCapitilization,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: isPasswordVisible,
        maxLines:
            textInputAction == TextInputAction.newline ? null : widget.maxLines,
        style: context.bodyText1,
        maxLengthEnforcement: widget.maxLengthEnforced
            ? MaxLengthEnforcement.enforced
            : MaxLengthEnforcement.none,
        onChanged: widget.onUpdate,
        //maxLines: widget.maxLines,
        autofocus: widget.autofocus,
        validator: FormBuilderValidators.compose(widget.validators),
        initialValue: widget.initialValue,
        onSubmitted: widget.onSubmit,
      ),
    );
  }
}
