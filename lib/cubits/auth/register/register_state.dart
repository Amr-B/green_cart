part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInital extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  final String error;
  RegisterError({required this.error});
}
