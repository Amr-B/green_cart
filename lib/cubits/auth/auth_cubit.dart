import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cart/data/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    checkLoginStatus();
  }

  Future<void> login(String email, String password, bool rememberMe) async {
    emit(AuthLoading());

    try {
      final response = await http.post(
        Uri.parse('${ApiEndPoints.baseUrl}/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        // ✅ حفظ التوكن فقط لو Remember Me مفعّلة
        if (rememberMe) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
        }

        emit(AuthSuccess(token));
      } else {
        final data = jsonDecode(response.body);
        emit(AuthFailure(data['error'] ?? 'Login failed'));
      }
    } catch (e) {
      emit(AuthFailure('Network error'));
    }
  }

  Future<void> register(String name, String email, String password) async {
    emit(AuthLoading());

    try {
      final response = await http.post(
        Uri.parse('${ApiEndPoints.baseUrl}/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        emit(AuthSuccess('Registered Successfully'));
      } else {
        final data = jsonDecode(response.body);
        emit(AuthFailure(data['error'] ?? 'Registration failed'));
      }
    } catch (e) {
      emit(AuthFailure('Network error'));
    }
  }

  Future<void> logout() async {
    // احذف التوكن أو أي بيانات محفوظة
    // مثلاً:
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    emit(AuthInitial());
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      emit(AuthSuccess(token));
    } else {
      emit(AuthInitial());
    }
  }
}
