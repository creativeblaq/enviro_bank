import 'dart:convert';

class ValidationResponse {
  final List<String> errors;
  final bool success;
  final List<String> warnings;

  ValidationResponse(this.errors, this.success, this.warnings);

  Map<String, dynamic> toMap() {
    return {
      'errors': errors,
      'success': success,
      'warnings': warnings,
    };
  }

  factory ValidationResponse.fromMap(Map<String, dynamic> map) {
    return ValidationResponse(
      List<String>.from(map['errors'] ?? []),
      map['success'] ?? false,
      List<String>.from(map['warnings'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ValidationResponse.fromJson(String source) =>
      ValidationResponse.fromMap(json.decode(source));

  ValidationResponse copyWith({
    List<String>? errors,
    bool? success,
    List<String>? warnings,
  }) {
    return ValidationResponse(
      errors ?? this.errors,
      success ?? this.success,
      warnings ?? this.warnings,
    );
  }

  @override
  String toString() =>
      'ValidationResponse(errors: $errors, success: $success, warnings: $warnings)';
}
