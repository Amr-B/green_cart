// core/services/data_service.dart
import 'package:dio/dio.dart';
import 'package:green_cart/core/error/api_exception.dart';

class DataService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Response> get(String url) async {
    try {
      final response = await _dio.get(url);
      return response;
    } on DioException catch (e) {
      throw ApiExceptions.handleDioError(e);
    }
  }

  Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } on DioException catch (e) {
      throw ApiExceptions.handleDioError(e);
    }
  }
}
