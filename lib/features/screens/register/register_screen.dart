import 'package:flutter/material.dart';
import 'package:green_cart/common/text_field.dart';
import 'package:green_cart/features/screens/home/home_screen.dart';
import 'package:green_cart/features/screens/login/login_screen.dart';
import 'package:green_cart/features/screens/register/widget/auth_settings_register.dart';
import 'package:green_cart/common/appbar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:green_cart/common/button.dart';
import 'package:green_cart/features/utils/animations.dart';
import 'package:green_cart/features/utils/colors.dart';
import 'package:green_cart/features/utils/images.dart';
import 'package:green_cart/features/utils/texts.dart';
import 'package:green_cart/features/utils/responsive.dart';

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
      appBar: KAppBar(title: 'Register'),
      body: SingleChildScrollView(
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
                Navigator.push(context, CustomPageRoute(child: LoginScreen()));
              },
            ),
            const SizedBox(height: 10),
            KButton(
              onTap: () {
                Navigator.push(context, CustomPageRoute(child: HomeScreen()));
              },
              screenHeight: screenHeight,
              title: 'Register',
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
