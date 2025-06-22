// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:green_cart/features/authentication/login/login_screen.dart';
import 'package:green_cart/features/utils/animations.dart';

import '../../../utils/colors.dart';

class KNextOnButton extends StatelessWidget {
  const KNextOnButton({
    super.key,
    required PageController controller,
  }) : _controller = controller;

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_controller.page!.round() < 2) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          // Navigate to login screen
          Navigator.push(context, CustomPageRoute(child: LoginScreen()));
        }
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: KColors.primary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          Icons.chevron_right,
          size: 26,
        ),
      ),
    );
  }
}
