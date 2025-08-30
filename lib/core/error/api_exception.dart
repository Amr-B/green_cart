import 'package:dio/dio.dart';

class ApiExceptions implements Exception {
  final String message;
  final int? statusCode;

  ApiExceptions(this.message, {this.statusCode});

  @override
  String toString() => "ApiExceptions: $message (code: $statusCode)";

  static ApiExceptions handleDioError(DioError e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiExceptions("Connection timed out");

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return ApiExceptions("Unauthorized", statusCode: 401);
        } else if (statusCode == 404) {
          return ApiExceptions("Not found", statusCode: 404);
        } else if (statusCode! >= 500) {
          return ApiExceptions("Server error", statusCode: statusCode);
        }
        return ApiExceptions("Unexpected error", statusCode: statusCode);

      case DioExceptionType.cancel:
        return ApiExceptions("Request cancelled");

      case DioExceptionType.unknown:
      default:
        return ApiExceptions("No internet or unknown error");
    }
  }
}
