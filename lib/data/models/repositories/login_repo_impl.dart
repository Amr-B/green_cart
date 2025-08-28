import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:green_cart/core/error/failure.dart';
import 'package:green_cart/core/services/api_service.dart';
import 'package:green_cart/data/api_endpoints.dart';
import 'package:green_cart/data/models/auth/login_model.dart';
import 'package:green_cart/data/models/repositories/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiService apiService;

  LoginRepoImpl(this.apiService);

  @override
  Future<Either<Failure, LoginModel>> loginUser({
    required email,
    required pw,
  }) async {
    try {
      final data = await apiService.post(
        endpoint: ApiEndPoints.login,
        data: {
          "email": email,
          "password": pw,
        },
      );

      return right(LoginModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
