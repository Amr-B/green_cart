// > widget imports
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cart/cubits/auth/register/register_cubit.dart';

// > utils imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cart/data/repositories/register/register_repo_impl.dart';
import 'package:green_cart/features/authentication/register/register_view_body.dart';

import '../../../core/services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterCubit(regRepo: RegisterRepoImpl(ApiService(Dio()))),
      child: RegisterViewBody(),
    );
  }
}
