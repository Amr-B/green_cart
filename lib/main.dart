import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:green_cart/cubits/auth/auth_cubit.dart';
import 'package:green_cart/cubits/cart/cart_item_cubit.dart';
import 'package:green_cart/features/presentation/onboarding/onboarding_screen.dart';
import 'package:green_cart/features/presentation/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final bool isLoggedIn = token != null;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => CartCubit()),
      ],
      child: MaterialApp(
        title: 'Green Cart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'SFProDisplay',
        ),
        home: isLoggedIn ? HomeScreen() : OnboardingScreen(),
      ),
    );
  }
}
