import 'package:flutter/material.dart';
import 'package:green_cart/features/utils/colors.dart';

class KPasswordField extends StatelessWidget {
  const KPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock_outline,
          color: KColors.primary,
        ),
        labelText: 'Password',
        labelStyle: TextStyle(color: KColors.primary),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: KColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
    );
  }
}
