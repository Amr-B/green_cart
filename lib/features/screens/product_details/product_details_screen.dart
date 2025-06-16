// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:green_cart/common/back_appbar_button.dart';
import 'package:green_cart/common/button.dart';
import 'package:green_cart/features/screens/cart/cart_screen.dart';
import 'package:green_cart/features/utils/animations.dart';
import 'package:green_cart/features/utils/colors.dart';
import 'package:green_cart/features/utils/images.dart';
import 'package:green_cart/features/utils/responsive.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    final screenHeight = Responsive.screenHeight(context);
    return Scaffold(
      backgroundColor: KColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: KBackAppBarButton(context),
            centerTitle: true,
            title: Text(
              'Potato',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                KImages.potatos,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // >> product title << //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Potatos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      )
                    ],
                  ),

                  // >> price & rating << //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // > price & KG
                      Row(
                        children: [
                          Text(
                            "12.99",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            "/kg",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),

                      // > rating
                      Row(
                        children: [
                          Image.asset(
                            KImages.starIcon,
                            height: 27,
                          ),
                          SizedBox(width: 8),

                          // > rating text
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              '4.5',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // > number of people who rated
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              '(2.3K)',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  // >> count << //

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (count > 1) count--;
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: KColors.primary.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.remove, size: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '$count',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            count++;
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: KColors.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child:
                                Icon(Icons.add, size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // >> description << //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.25),
                  // >> add to cart << //
                  KButton(
                    screenHeight: screenHeight,
                    title: 'Add to cart - 24.99',
                    onTap: () {
                      Navigator.push(
                          context, CustomPageRoute(child: CartScreen()));
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
