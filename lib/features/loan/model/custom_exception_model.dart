//AN exception class to simplify showing exeptions in the app
class CustomException implements Exception {
  final String errorCode;
  final String? message;
  CustomException(this.errorCode, this.message);
}
