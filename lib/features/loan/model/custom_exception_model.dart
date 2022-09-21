class CustomException implements Exception {
  final String errorCode;
  final String? message;
  CustomException(this.errorCode, this.message);
}
