import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cart/data/repositories/register/register_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.regRepo}) : super(RegisterInital());

  RegisterRepo regRepo;

  // > controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> regKey = GlobalKey();
  bool rememberMe = false;
  bool isLoading = false;

  Future<void> regUser(String name, String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLoading = true;
    emit(RegisterLoading());

    try {
      var result = await regRepo.regUser(
        name: nameController.text,
        email: emailController.text,
        pw: passwordController.text,
      );

      result.fold(
        (failure) {
          isLoading = false;
          emit(RegisterError(error: failure.errMsg));
        },
        (token) {
          isLoading = false;
          pref.setString('token', token.data.token);
          emit(RegisterSuccess());
        },
      );
    } catch (e) {
      isLoading = false;

      emit(RegisterError(error: "Unexpected error $e"));
    }
  }
}
