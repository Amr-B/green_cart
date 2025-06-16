import 'package:flutter/material.dart';
import 'package:green_cart/common/button.dart';
import 'package:green_cart/features/screens/cart/widgets/cart_item.dart';
import 'package:green_cart/features/screens/cart/widgets/payment_item.dart';
import 'package:green_cart/features/screens/cart/widgets/total_amount.dart';
import 'package:green_cart/features/utils/colors.dart';
import 'package:green_cart/features/utils/images.dart';
import 'package:green_cart/features/utils/responsive.dart';

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
      appBar: AppBar(
        toolbarHeight: 100,
        foregroundColor: KColors.background,
        centerTitle: true,
        backgroundColor: KColors.dGreen,
        title: Text(
          'Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.05,
        ),
        child: Column(
          children: [
            CartItemCard(
              image: KImages.potatos,
              name: 'Potato',
              price: '5.99',
              weight: '1 KG',
              count: count,
              onCountChanged: updateCount,
            ),
            SizedBox(height: screenHeight * 0.09),
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
                    PaymentItem(
                      price: '5.99',
                      title: 'Total',
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    PaymentItem(
                      price: '5.00',
                      title: 'Delivery Fee',
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // > total anount
                    KTotalAmount(),
                    SizedBox(height: screenHeight * 0.1),
                    // > checkout button
                    KButton(
                      screenHeight: screenHeight,
                      title: 'Checkout',
                      onTap: () {},
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
