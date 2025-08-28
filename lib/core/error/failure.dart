import 'package:dio/dio.dart';

abstract class Failure {
  final String errMsg;

  Failure(this.errMsg);
}

// > concrete subclass of Failure for server-related errors

class ServerFailure extends Failure {
  ServerFailure(super.errMsg);

  // > factory method to create a server failure instance from a DioError
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Sorry, Connection Time Out with Api Server');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Time Out');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Recive Time Out');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode, dioError.response!.data);

      case DioExceptionType.cancel:
        return ServerFailure('Request was canceled');

      case DioExceptionType.unknown:
        return ServerFailure('No Internet Connection');

      default:
        return ServerFailure('There was an error, Try again later');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 422) {
      return ServerFailure(response['message']);
    } else if (statusCode == 404) {
      return ServerFailure(response['error']);
    } else if (statusCode == 500) {
      return ServerFailure('International Server Error, Try again later');
    } else {
      return ServerFailure('Unknown Error, Try again later');
    }
  }
}
