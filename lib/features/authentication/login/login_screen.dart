// ignore_for_file: use_build_context_synchronously

// > widget imports
import 'package:flutter/material.dart';
import 'package:green_cart/common/auth_appbar.dart';
import 'package:green_cart/common/text_field.dart';
import 'package:green_cart/features/presentation/home/home_screen.dart';
import 'package:green_cart/features/authentication/login/widgets/auth_settings.dart';
import 'package:green_cart/common/button.dart';
import 'package:green_cart/features/authentication/register/register_screen.dart';
import 'package:green_cart/config/animations/animations.dart';

// > utils imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cart/cubits/auth/auth_cubit.dart';
import 'package:green_cart/cubits/auth/auth_state.dart';
import 'package:green_cart/config/themes/colors.dart';
import 'package:green_cart/config/strings/images.dart';
import 'package:green_cart/config/strings/texts.dart';
import 'package:green_cart/config/responsive/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = Responsive.screenHeight(context);

    return Scaffold(
      backgroundColor: KColors.background,
      appBar: KAuthAppBar(title: 'Login'),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }

          if (state is AuthSuccess) {
            if (rememberMe) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                  'loggedInEmail', emailController.text.trim());
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Welcome!')),
            );

            Navigator.push(
              context,
              CustomPageRoute(
                child: HomeScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.08),
                _buildLogo(screenHeight),
                SizedBox(height: 20),
                _buildHeadlines(),
                SizedBox(height: 30),

                AuthTextField(
                  controller: emailController,
                  obscureText: false,
                  icon: Icons.email_outlined,
                  hintText: 'Email',
                ),
                const SizedBox(height: 15),
                AuthTextField(
                  controller: passwordController,
                  obscureText: true,
                  icon: Icons.lock_outline,
                  hintText: 'Password',
                ),

                // > remember me
                KAuthSettingsLogin(
                  rememberMe: rememberMe,
                  onRememberChanged: (value) {
                    setState(() => rememberMe = value!);
                  },

                  // > register instead
                  onRegisterTap: () {
                    Navigator.push(
                        context, CustomPageRoute(child: RegisterScreen()));
                  },
                ),
                SizedBox(height: 10),
                KButton(
                  onTap: () {
                    context.read<AuthCubit>().login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          rememberMe,
                        );
                  },
                  screenHeight: screenHeight,
                  title: 'Login',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo(double screenHeight) {
    return Center(
      child: Image.asset(
        KImages.logo,
        height: screenHeight * 0.2,
      ),
    );
  }

  Widget _buildHeadlines() {
    return Column(
      children: [
        Text(
          KText.headLineLogin,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: KColors.primary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          KText.subTitleLogin,
          style: TextStyle(
            fontSize: 14,
            color: KColors.primary,
          ),
        ),
      ],
    );
  }
}
