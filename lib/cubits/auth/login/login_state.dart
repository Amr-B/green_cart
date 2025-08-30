part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInital extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String error;
  LoginError({required this.error});
}
