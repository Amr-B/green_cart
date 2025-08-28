import 'package:dartz/dartz.dart';
import 'package:green_cart/data/models/auth/login_model.dart';

import '../../../core/error/failure.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> loginUser({
    required email,
    required pw,
  });
}
