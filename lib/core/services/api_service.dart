import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<Map<String, dynamic>> post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.post(
      endpoint,
      data: data,
      options: Options(
        headers: {},
      ),
    );

    return response.data;
  }
}
