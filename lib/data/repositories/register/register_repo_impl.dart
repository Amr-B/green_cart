import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:green_cart/core/error/failure.dart';
import 'package:green_cart/core/services/api_service.dart';
import 'package:green_cart/data/api_endpoints.dart';
import 'package:green_cart/data/models/auth/register_model.dart';
import 'package:green_cart/data/repositories/register/register_repo.dart';

class RegisterRepoImpl implements RegisterRepo {
  final ApiService apiService;

  RegisterRepoImpl(this.apiService);

  @override
  Future<Either<Failure, RegisterModel>> regUser(
      {required name, required email, required pw}) async {
    try {
      final regData = await apiService.post(
        endpoint: ApiEndPoints.register,
        data: {
          "name": name,
          "email": email,
          "password": pw,
        },
      );

      return right(RegisterModel.fromJson(regData));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
