import 'package:dio/dio.dart';
import 'package:enviro_bank/features/authentication/model/user_model.dart';
import 'package:enviro_bank/features/authentication/model/validation_respnse_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///this class contains all the methods for making authentication
///requests to the server
class AuthRepository {
  final String baseUrl =
      "http://ec2-63-33-169-221.eu-west-1.compute.amazonaws.com/loans-api/users";

  //the package for making requests easier
  var dio = Dio();

  //the auth user if available
  User? user;

  //request for logging in the user
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

  //request for registering a new user
  Future<String> register(User credentials) async {
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

  //request for updating user password
  Future<bool> updatePassword(User newUser) async {
    try {
      await dio.put(baseUrl, data: newUser.toJson());
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
