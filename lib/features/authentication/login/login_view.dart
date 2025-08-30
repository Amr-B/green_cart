// > widget imports
import 'package:green_cart/features/authentication/login/login_view_body.dart';

// > utils imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cart/cubits/auth/login/login_cubit.dart';
import '../../../core/services/api_service.dart';
import '../../../data/repositories/login/login_repo_impl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(loginRepo: LoginRepoImpl(ApiService(Dio()))),
      child: LoginViewBody(),
    );
  }
}
