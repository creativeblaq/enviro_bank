import 'dart:convert';

class LoanApplicationResponse {
  final bool approved;
  final List<String> errors;
  final List<String> warnings;
  final String reference;

  LoanApplicationResponse(
      this.approved, this.errors, this.warnings, this.reference);

  Map<String, dynamic> toMap() {
    return {
      'approved': approved,
      'errors': errors,
      'warnings': warnings,
      'reference': reference,
    };
  }

  factory LoanApplicationResponse.fromMap(Map<String, dynamic> map) {
    return LoanApplicationResponse(
      map['approved'] ?? false,
      List<String>.from(map['errors']),
      List<String>.from(map['warnings']),
      map['reference'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanApplicationResponse.fromJson(String source) =>
      LoanApplicationResponse.fromMap(json.decode(source));

  LoanApplicationResponse copyWith({
    bool? approved,
    List<String>? errors,
    List<String>? warnings,
    String? reference,
  }) {
    return LoanApplicationResponse(
      approved ?? this.approved,
      errors ?? this.errors,
      warnings ?? this.warnings,
      reference ?? this.reference,
    );
  }

  @override
  String toString() {
    return 'LoanApplicationResponse(approved: $approved, errors: $errors, warnings: $warnings, reference: $reference)';
  }
}
