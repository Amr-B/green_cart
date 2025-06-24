// > widget imports
import 'package:flutter/material.dart';
import 'package:green_cart/common/text_field.dart';
import 'package:green_cart/features/authentication/login/login_screen.dart';
import 'package:green_cart/features/authentication/register/widget/auth_settings_register.dart';
import 'package:green_cart/common/auth_appbar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:green_cart/common/button.dart';

// > utils imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cart/cubits/auth/auth_cubit.dart';
import 'package:green_cart/cubits/auth/auth_state.dart';
import 'package:green_cart/config/animations/animations.dart';
import 'package:green_cart/config/themes/colors.dart';
import 'package:green_cart/config/strings/images.dart';
import 'package:green_cart/config/strings/texts.dart';
import 'package:green_cart/config/responsive/responsive.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = Responsive.screenHeight(context);

    return Scaffold(
        backgroundColor: KColors.background,
        appBar: KAuthAppBar(title: 'Register'),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registered Successfully')));
              Navigator.pushReplacement(
                context,
                CustomPageRoute(child: LoginScreen()),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.07),
                  _buildLogo(screenHeight),
                  const SizedBox(height: 20),
                  _buildHeadlines(),
                  const SizedBox(height: 20),
                  // > name field
                  AuthTextField(
                    controller: nameController,
                    obscureText: false,
                    icon: Iconsax.user,
                    hintText: 'Name',
                  ),
                  const SizedBox(height: 20),
                  // > email field
                  AuthTextField(
                    controller: emailController,
                    obscureText: false,
                    icon: Icons.email_outlined,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 20),
                  // > password field
                  AuthTextField(
                    controller: passwordController,
                    obscureText: true,
                    icon: Icons.lock_outline,
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 10),
                  // > remember me
                  KAuthSettingsRegister(
                    rememberMe: rememberMe,
                    onRememberChanged: (value) {
                      setState(() => rememberMe = value!);
                    },
                    onRegisterTap: () {
                      Navigator.push(
                          context, CustomPageRoute(child: LoginScreen()));
                    },
                  ),
                  const SizedBox(height: 10),
                  KButton(
                    onTap: isLoading
                        ? () {}
                        : () {
                            final name = nameController.text.trim();
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Fill all fields')),
                              );
                              return;
                            }

                            context
                                .read<AuthCubit>()
                                .register(name, email, password);
                          },
                    screenHeight: screenHeight,
                    title: isLoading ? 'Loading...' : 'Register',
                  ),
                ],
              ),
            );
          },
        ));
  }

  Widget _buildLogo(double screenHeight) {
    return Center(
      child: Image.asset(
        KImages.logo,
        height: screenHeight * 0.12,
      ),
    );
  }

  Widget _buildHeadlines() {
    return Column(
      children: [
        Text(
          KText.headLineLogin,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: KColors.primary,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          KText.subTitleLogin,
          style: const TextStyle(
            fontSize: 12,
            color: KColors.primary,
          ),
        ),
      ],
    );
  }
}
