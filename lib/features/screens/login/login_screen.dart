import 'package:flutter/material.dart';
import 'package:green_cart/common/appbar.dart';
import 'package:green_cart/features/screens/login/widgets/auth_settings.dart';
import 'package:green_cart/features/screens/login/widgets/login_button.dart';
import 'package:green_cart/features/screens/login/widgets/password_field.dart';
import 'package:green_cart/features/screens/login/widgets/email_fields.dart';
import 'package:green_cart/features/utils/colors.dart';
import 'package:green_cart/features/utils/images.dart';
import 'package:green_cart/features/utils/texts.dart';
import 'package:green_cart/features/utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = Responsive.screenHeight(context);

    return Scaffold(
      backgroundColor: KColors.background,
      appBar: const KAppBar(title: 'Login'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            _buildLogo(screenHeight),
            const SizedBox(height: 20),
            _buildHeadlines(),
            const SizedBox(height: 20),
            const KEmailField(),
            const SizedBox(height: 20),
            const KPasswordField(),
            const SizedBox(height: 10),
            KAuthSettings(
              rememberMe: rememberMe,
              onRememberChanged: (value) {
                setState(() => rememberMe = value!);
              },
              onRegisterTap: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
            const SizedBox(height: 10),
            KLoginButton(screenHeight: screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(double screenHeight) {
    return Center(
      child: Image.asset(
        KImages.logo,
        height: screenHeight * 0.3,
      ),
    );
  }

  Widget _buildHeadlines() {
    return Column(
      children: [
        Text(
          KText.headLineLogin,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: KColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          KText.subTitleLogin,
          style: const TextStyle(
            fontSize: 14,
            color: KColors.primary,
          ),
        ),
      ],
    );
  }
}
