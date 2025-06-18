import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:green_cart/features/screens/cart/cart_screen.dart';
import 'package:green_cart/features/screens/home/home_content.dart';
import 'package:green_cart/features/screens/profile/profile_screen.dart';
import 'package:green_cart/features/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 1;

  final pages = [
    const ProfileScreen(),
    const HomeContent(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: pages[index],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: index,
        height: 60,
        backgroundColor: Colors.transparent,
        color: Colors.grey.shade300,
        buttonBackgroundColor: Colors.black,
        animationDuration: Duration(milliseconds: 400),
        animationCurve: Curves.easeInOut,
        items: [
          Icon(
            Icons.person_outline,
            color: index == 0 ? Colors.amber : Colors.black,
          ),
          Icon(
            Icons.home_outlined,
            color: index == 1 ? Colors.amber : Colors.black,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: index == 2 ? Colors.amber : Colors.black,
          ),
        ],
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}
