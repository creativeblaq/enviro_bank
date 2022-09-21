import 'dart:convert';

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
