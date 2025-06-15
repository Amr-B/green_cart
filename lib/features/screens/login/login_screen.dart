import 'package:flutter/material.dart';
import 'package:green_cart/common/appbar.dart';
import 'package:green_cart/common/text_field.dart';
import 'package:green_cart/features/screens/home/home_screen.dart';
import 'package:green_cart/features/screens/login/widgets/auth_settings.dart';
import 'package:green_cart/common/button.dart';
import 'package:green_cart/features/screens/register/register_screen.dart';
import 'package:green_cart/features/utils/animations.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = Responsive.screenHeight(context);

    return Scaffold(
      backgroundColor: KColors.background,
      appBar: KAppBar(title: 'Login'),
      body: SingleChildScrollView(
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
                Navigator.push(context, CustomPageRoute(child: HomeScreen()));
              },
              screenHeight: screenHeight,
              title: 'Login',
            ),
          ],
        ),
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
