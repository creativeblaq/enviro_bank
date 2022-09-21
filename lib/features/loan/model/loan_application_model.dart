import 'dart:convert';

class LoanApplication {
  final double amount;
  final BankAccount bankAccount;
  final String collectionDate;
  final String firstName;
  final String lastName;
  final String idNumber;

  LoanApplication(this.amount, this.bankAccount, this.collectionDate,
      this.firstName, this.lastName, this.idNumber);

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'bankAccount': bankAccount.toMap(),
      'collectionDate': collectionDate,
      'firstName': firstName,
      'lastName': lastName,
      'idNumber': idNumber,
    };
  }

  factory LoanApplication.fromMap(Map<String, dynamic> map) {
    return LoanApplication(
      map['amount']?.toDouble() ?? 0.0,
      BankAccount.fromMap(map['bankAccount']),
      map['collectionDate'] ?? '',
      map['firstName'] ?? '',
      map['lastName'] ?? '',
      map['idNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanApplication.fromJson(String source) =>
      LoanApplication.fromMap(json.decode(source));

  LoanApplication copyWith({
    double? amount,
    BankAccount? bankAccount,
    String? collectionDate,
    String? firstName,
    String? lastName,
    String? idNumber,
  }) {
    return LoanApplication(
      amount ?? this.amount,
      bankAccount ?? this.bankAccount,
      collectionDate ?? this.collectionDate,
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      idNumber ?? this.idNumber,
    );
  }

  @override
  String toString() {
    return 'LoanApplication(amount: $amount, bankAccount: $bankAccount, collectionDate: $collectionDate, firstName: $firstName, lastName: $lastName, idNumber: $idNumber)';
  }
}

class BankAccount {
  final String accountNumber;
  final String bankName;
  final String branchCode;

  BankAccount(this.accountNumber, this.bankName, this.branchCode);

  Map<String, dynamic> toMap() {
    return {
      'accountNumber': accountNumber,
      'bankName': bankName,
      'branchCode': branchCode,
    };
  }

  factory BankAccount.fromMap(Map<String, dynamic> map) {
    return BankAccount(
      map['accountNumber'] ?? '',
      map['bankName'] ?? '',
      map['branchCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BankAccount.fromJson(String source) =>
      BankAccount.fromMap(json.decode(source));

  BankAccount copyWith({
    String? accountNumber,
    String? bankName,
    String? branchCode,
  }) {
    return BankAccount(
      accountNumber ?? this.accountNumber,
      bankName ?? this.bankName,
      branchCode ?? this.branchCode,
    );
  }

  @override
  String toString() =>
      'BankAccount(accountNumber: $accountNumber, bankName: $bankName, branchCode: $branchCode)';
}

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

class User {
  final String emailAddress;
  final String password;

  User(this.emailAddress, this.password);

  User copyWith({
    String? emailAddress,
    String? password,
  }) {
    return User(
      emailAddress ?? this.emailAddress,
      password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'emailAddress': emailAddress,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['emailAddress'] ?? '',
      map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(emailAddress: $emailAddress, password: $password)';
}

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
