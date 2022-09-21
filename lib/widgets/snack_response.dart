import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';

class SnackResponse {
  static SnackBar success({
    required BuildContext context,
    String title = 'Success',
    String message = "Everything went well.",
    TextStyle? titleStyle,
    TextStyle? msgStyle,
    int? maxLines,
    Duration duration = const Duration(
      milliseconds: 4000,
    ),
  }) {
    return defaultSnack(
        duration: duration,
        title: title,
        color: Colors.green,
        context: context,
        message: message);
  }

  static SnackBar error({
    required BuildContext context,
    String title = 'Error',
    String message = "Something went wrong.",
    TextStyle? titleStyle,
    TextStyle? msgStyle,
    int? maxLines,
    Duration duration = const Duration(
      milliseconds: 4000,
    ),
  }) {
    return defaultSnack(
        duration: duration,
        title: title,
        color: Colors.red,
        context: context,
        message: message);
  }

  static SnackBar warning({
    required BuildContext context,
    String title = 'Warning',
    String message = "Something went wrong.",
    TextStyle? titleStyle,
    TextStyle? msgStyle,
    int? maxLines,
    Duration duration = const Duration(
      milliseconds: 4000,
    ),
  }) {
    return defaultSnack(
        duration: duration,
        title: title,
        color: Colors.orange,
        context: context,
        message: message);
  }

  static SnackBar defaultSnack(
      {required Duration duration,
      required String title,
      required Color color,
      TextStyle? titleStyle,
      required BuildContext context,
      required String message,
      TextStyle? msgStyle}) {
    return SnackBar(
      duration: duration,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      dismissDirection: DismissDirection.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: titleStyle ??
                context.h6.copyWith(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            message,
            style: msgStyle ?? context.bodyText2,
          ),
        ],
      ),
    );
  }
}
