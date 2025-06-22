import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cart/cubits/cart/cart_item_cubit.dart';
import 'package:green_cart/features/presentation/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => CartCubit())],
      child: MaterialApp(
        title: 'Green Cart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'SFProDisplay',
        ),
        home: OnboardingScreen(),
      ),
    );
  }
}
