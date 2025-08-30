import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:green_cart/data/repositories/login/login_repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginRepo}) : super(LoginInital());

  LoginRepo loginRepo;

  // > controllers

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey();
  bool rememberMe = false;
  bool isLoading = false;

  Future<void> loginUser(String text, String trim, bool rememberMe) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLoading = true;
    emit(LoginLoading());

    try {
      var result = await loginRepo.loginUser(
        email: emailController.text,
        pw: passwordController.text,
      );

      result.fold(
        (failure) {
          isLoading = false;
          emit(LoginError(error: failure.errMsg));
        },
        (token) {
          isLoading = false;
          pref.setString('token', token.data.token);
          emit(LoginSuccess());
        },
      );
    } catch (e) {
      isLoading = false;
      emit(LoginError(error: "Unexpected error: $e"));
    }
  }
}
