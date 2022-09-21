import 'package:dio/dio.dart';
import 'package:enviro_bank/features/authentication/controller/auth_controller.dart';
import 'package:enviro_bank/features/loan/model/loan_application_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomException implements Exception {
  final String errorCode;
  final String? message;
  CustomException(this.errorCode, this.message);
}

class LoanRepository {
  final String baseUrl =
      "http://ec2-63-33-169-221.eu-west-1.compute.amazonaws.com/loans-api/loans";
  var dio = Dio();
  final String token;

  LoanRepository(this.token);

  Future<LoanApplicationResponse> apply(LoanApplication loanApplication) async {
    if (token.trim().isEmpty) {
      throw CustomException('INVALID_TOKEN_ERR', "No token provided");
    }
    try {
      var response = await dio.post(
        baseUrl,
        data: loanApplication.toJson(),
        options: Options(headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": token
        }),
      );
      Map<String, dynamic> data = response.data;
      if (kDebugMode) {
        print(response);
      }
      return LoanApplicationResponse.fromMap(data);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.response);
      }
      return LoanApplicationResponse.fromMap(e.response?.data ?? {});
    } catch (err) {
      if (kDebugMode) {
        print(err.toString());
      }
      throw CustomException('UNKNOWN_ERR', err.toString());
    }
  }
}

final loanRepositoryProvider = Provider<LoanRepository>((ref) {
  final String token = ref.read(authControllerProvider).props.first.toString();
  return LoanRepository(token);
});
