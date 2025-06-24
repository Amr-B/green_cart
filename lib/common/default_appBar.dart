// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:green_cart/config/themes/colors.dart';
import 'package:green_cart/features/presentation/home/home_screen.dart';
import 'package:green_cart/config/animations/animations.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool useDefaultBackground;

  const KAppBar({
    super.key,
    required this.title,
    this.useDefaultBackground = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            CustomPageRoute(child: const HomeScreen()),
          );
        },
        icon: const Icon(Icons.chevron_left),
      ),
      toolbarHeight: 100,
      foregroundColor: useDefaultBackground ? Colors.white : KColors.dGreen,
      centerTitle: true,
      surfaceTintColor: KColors.background,
      backgroundColor:
          useDefaultBackground ? KColors.dGreen : KColors.background,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      ),
    );
  }
}
