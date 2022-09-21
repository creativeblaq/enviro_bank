import 'package:dio/dio.dart';
import 'package:enviro_bank/features/authentication/controller/auth_controller.dart';
import 'package:enviro_bank/features/loan/model/custom_exception_model.dart';
import 'package:enviro_bank/features/loan/model/loan_application_model.dart';
import 'package:enviro_bank/features/loan/model/loan_application_respose_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///this class handles the communication with the rest-api for the loan application
class LoanRepository {
  final String baseUrl =
      "http://ec2-63-33-169-221.eu-west-1.compute.amazonaws.com/loans-api/loans";
  var dio = Dio();
  final String token;

  LoanRepository(this.token);

  Future<LoanApplicationResponse> apply(LoanApplication loanApplication) async {
    if (token.trim().isEmpty) {
      //if the user is not logged in or a token is not provided
      //throw an error
      throw CustomException('INVALID_TOKEN_ERR', "No token provided");
    }
    try {
      //make a request to the loan endpoint for the loan application
      var response = await dio.post(
        baseUrl,
        data: loanApplication.toJson(),
        options: Options(headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": token
        }),
      );
      //get the response data/body
      Map<String, dynamic> data = response.data;
      if (kDebugMode) {
        print(response);
      }
      //pass the data as loan response
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
