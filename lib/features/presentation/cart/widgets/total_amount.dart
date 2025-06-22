import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cart/config/themes/colors.dart';
import 'package:green_cart/cubits/cart/cart_item_cubit.dart';

class KTotalAmount extends StatelessWidget {
  const KTotalAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        const deliveryFee = 5.0;
        final total = state.total + deliveryFee;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: KColors.secondary,
              ),
            ),
          ],
        );
      },
    );
  }
}
