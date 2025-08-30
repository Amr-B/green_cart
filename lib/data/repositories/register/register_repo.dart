import 'package:dartz/dartz.dart';
import '../../models/auth/register_model.dart';

import 'package:green_cart/core/error/failure.dart';

abstract class RegisterRepo {
  Future<Either<Failure, RegisterModel>> regUser({
    required name,
    required email,
    required pw,
  });
}
