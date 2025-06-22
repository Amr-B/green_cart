import 'package:flutter/material.dart';
import 'package:green_cart/config/themes/colors.dart';

class KAuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const KAuthAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      surfaceTintColor: KColors.background,
      backgroundColor: KColors.background,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
            color: KColors.primary,
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: 40,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
