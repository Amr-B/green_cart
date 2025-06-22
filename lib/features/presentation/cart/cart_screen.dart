import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cart/common/button.dart';
import 'package:green_cart/common/default_appBar.dart';
import 'package:green_cart/cubits/cart/cart_item_cubit.dart';
import 'package:green_cart/features/presentation/cart/recipe_screen.dart';
import 'package:green_cart/features/presentation/cart/widgets/cart_item.dart';
import 'package:green_cart/features/presentation/cart/widgets/payment_item.dart';
import 'package:green_cart/features/presentation/cart/widgets/total_amount.dart';
import 'package:green_cart/config/themes/colors.dart';
import 'package:green_cart/config/responsive/responsive.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int count = 1;

  void updateCount(int newCount) {
    setState(() {
      count = newCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = Responsive.screenHeight(context);
    final screenWidth = Responsive.screenWidth(context);
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: KAppBar(title: 'Cart'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.05,
        ),
        child: Column(
          children: [
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Column(
                  children: state.items
                      .map(
                        (item) => Column(
                          children: [
                            CartItemCard(
                              image: item.image,
                              name: item.name,
                              price: item.unitPrice.toStringAsFixed(2),
                              weight: '${item.count} ×',
                              count: item.count,
                              onCountChanged: (newCount) {
                                context
                                    .read<CartCubit>()
                                    .updateCount(item.name, newCount);
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      )
                      .toList(),
                );
              },
            ),

            SizedBox(height: screenHeight * 0.04),
            Divider(color: Colors.black),
            SizedBox(height: screenHeight * 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Payment Summary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // > payment summary
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return PaymentItem(
                          price: state.total.toStringAsFixed(2),
                          title: 'Total',
                        );
                      },
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    PaymentItem(
                      price: '5.00',
                      title: 'Delivery Fee',
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // > total anount
                    KTotalAmount(),
                    SizedBox(height: screenHeight * 0.06),

                    // > checkout button
                    KButton(
                      screenHeight: screenHeight,
                      title: 'Checkout',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ReceiptScreen(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
