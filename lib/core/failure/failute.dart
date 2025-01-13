import 'package:dio/dio.dart';

abstract class Failure{
  final String message;
  Failure({required this.message});
}

class AuthFailure extends Failure{
  AuthFailure({required super.message});
}

class UserDetailsFailure extends Failure{
  UserDetailsFailure({required super.message});
}


class DioErrorHandler {
  static AuthFailure handleDioError(DioException e) {
    String errorMessage;

    // Handle different DioError types for better error descriptions.
    if (e.response != null) {
      // If there's a server response, provide details.
      errorMessage = "Error ${e.response?.statusCode}: ${e.response?.statusMessage ?? 'Unknown error'}";
      if (e.response?.data != null) {
        errorMessage += "\nDetails: ${e.response?.data}";
      }
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      // Handle timeouts.
      errorMessage = "Request timed out. Please check your connection.";
    } else if (e.type == DioExceptionType.badCertificate) {
      errorMessage = "Bad certificate encountered.";
    } else {
      // Fallback for other Dio errors.
      errorMessage = "An unexpected network error occurred: ${e.message}";
    }

    return AuthFailure(message: errorMessage);
  }
}