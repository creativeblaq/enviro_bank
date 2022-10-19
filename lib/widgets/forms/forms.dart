import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

///Form methods used to modify and access form fields

class Forms {
  static getFormField(GlobalKey<FormBuilderState> form, String field) {
    return form.currentState?.fields[field]!.value;
  }

  static void setFormField(
      {required GlobalKey<FormBuilderState> form,
      required String field,
      required dynamic val}) {
    form.currentState!.fields[field]?.didChange(val);
    // form.currentState?.activate()
  }

  static formfieldHasFocus(formKey, field) {
    if (formKey.currentState?.fields[field] != null) {
      return formKey.currentState!.fields[field]!.effectiveFocusNode.hasFocus;
    } else {
      return false;
    }
  }
}
