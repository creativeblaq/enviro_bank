import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enviro_bank/features/loan/model/loan_application_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthRepository {
  final String baseUrl =
      "http://ec2-63-33-169-221.eu-west-1.compute.amazonaws.com/loans-api/users";
  var dio = Dio();
  User? user;
  Future<String> login(User credentials) async {
    try {
      var response =
          await dio.post("$baseUrl/login", data: credentials.toJson());
      Map<String, dynamic> data = response.data;
      user = credentials;
      return data["jwt"];
    } on DioError catch (e) {
      user = null;
      throw ValidationResponse.fromMap(e.response?.data ?? {});
    } catch (err) {
      user = null;
      return err.toString();
    }
  }

  Future<String> register(User credentials) async {
    //TODO: resgister then login
    try {
      var response = await dio.post(baseUrl, data: credentials.toJson());
      Map<String, dynamic> data = response.data;
      if (data["success"] == true) {
        user = credentials;
        return await login(credentials);
      }
      return "";
    } on DioError catch (e) {
      user = null;

      throw ValidationResponse.fromMap(e.response?.data ?? {});
    } catch (err) {
      user = null;

      return err.toString();
    }
  }

  Future<bool> updatePassword(User newUser) async {
    try {
      var response = await dio.put(baseUrl, data: newUser.toJson());
      Map<String, dynamic> data = response.data;
      user = newUser;
      return true;
    } on DioError catch (e) {
      throw ValidationResponse.fromMap(e.response?.data ?? {});
    } catch (err) {
      return false;
    }
  }
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository());
