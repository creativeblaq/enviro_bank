import 'package:enviro_bank/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormTemplate extends StatefulWidget {
  const FormTemplate({
    Key? key,
    // required this.form,
    this.onSubmit,
    required this.formFields,
    required this.formTitle,
    this.btnRadius = 30.0,
    this.formEnabled = true,
  }) : super(key: key);

  // final FormGroup formKey;
  final String formTitle;
  final List<Widget> Function(GlobalKey<FormBuilderState> form) formFields;
  final Function(GlobalKey<FormBuilderState> form)? onSubmit;
  final double btnRadius;
  final bool formEnabled;
  //final bool enableBtn;

  @override
  State<FormTemplate> createState() => _FormTemplateState();
}

class _FormTemplateState extends State<FormTemplate> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _enableBtn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: FormBuilder(
        key: _formKey,
        // enabled: false,
        autovalidateMode: AutovalidateMode.always,
        skipDisabled: true,
        enabled: widget.formEnabled,
        onChanged: () {
          if (_formKey.currentState != null) {
            //_formKey.currentState!.save();
            setState(() {
              _enableBtn = _formKey.currentState!.validate();
            });
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...widget.formFields(_formKey),
              if (widget.onSubmit != null)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _enableBtn && widget.formEnabled ? 1 : 0.2,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: LoadingButton(
                      key: Key("${widget.formTitle}-button"),
                      title: widget.formTitle,
                      onTap: () {
                        if (widget.formEnabled && _enableBtn) {
                          return widget.onSubmit!(_formKey);
                        }
                      },
                      radius: widget.btnRadius,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
