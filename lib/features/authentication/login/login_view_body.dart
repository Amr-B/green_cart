import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:green_cart/common/auth_appbar.dart';
import 'package:green_cart/common/text_field.dart';
import 'package:green_cart/features/presentation/home/home_screen.dart';
import 'package:green_cart/features/authentication/login/widgets/auth_settings.dart';
import 'package:green_cart/common/button.dart';
import 'package:green_cart/features/authentication/register/register_screen.dart';
import 'package:green_cart/config/themes/colors.dart';
import 'package:green_cart/config/strings/images.dart';
import 'package:green_cart/config/strings/texts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/animations/animations.dart';
import '../../../config/responsive/responsive.dart';
import '../../../cubits/auth/login/login_cubit.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    // > call login cubit
    var c = context.read<LoginCubit>();

    // > call responsive
    final screenHeight = Responsive.screenHeight(context);

    return Scaffold(
      backgroundColor: KColors.background,
      appBar: KAuthAppBar(title: 'Login'),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }

          if (state is LoginSuccess) {
            if (c.rememberMe) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                  'loggedInEmail', c.emailController.text.trim());
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
          if (state is LoginLoading) {
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
                  controller: c.emailController,
                  obscureText: false,
                  icon: Icons.email_outlined,
                  hintText: 'Email',
                ),
                const SizedBox(height: 15),
                AuthTextField(
                  controller: c.passwordController,
                  obscureText: true,
                  icon: Icons.lock_outline,
                  hintText: 'Password',
                ),

                // > remember me
                KAuthSettingsLogin(
                  rememberMe: c.rememberMe,
                  onRememberChanged: (value) {
                    setState(() => c.rememberMe = value!);
                  },

                  // > register instead
                  onRegisterTap: () {
                    Navigator.push(
                        context, CustomPageRoute(child: Container()));
                  },
                ),
                SizedBox(height: 10),
                KButton(
                  onTap: () {
                    context.read<LoginCubit>().loginUser(
                          c.emailController.text.trim(),
                          c.passwordController.text.trim(),
                          c.rememberMe,
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
