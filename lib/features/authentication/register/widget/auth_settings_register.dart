import 'package:flutter/material.dart';
import '../../../../config/themes/colors.dart';

class KAuthSettingsRegister extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onRegisterTap;

  const KAuthSettingsRegister({
    super.key,
    required this.rememberMe,
    required this.onRememberChanged,
    required this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              activeColor: KColors.primary,
              value: rememberMe,
              onChanged: onRememberChanged,
            ),
            Text(
              "Remember me",
              style: TextStyle(
                color: KColors.primary,
                fontSize: 14,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: onRegisterTap,
          child: const Text(
            "Login instead",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: KColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
