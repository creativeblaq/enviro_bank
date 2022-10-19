import 'dart:convert';

import 'package:enviro_bank/features/loan/model/bank_account_model.dart';

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
    return 'LoanApplication(amount: $amount, bankAccount: $bankAccount, collectionDate: $collectionDate,'
        ' firstName: $firstName, lastName: $lastName, idNumber: $idNumber)';
  }
}
