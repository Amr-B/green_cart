// ignore_for_file: unnecessary_to_list_in_spreads

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cart/common/icon_button.dart';
import 'package:green_cart/config/strings/images.dart';
import 'package:green_cart/cubits/cart/cart_item_cubit.dart';
import 'package:green_cart/data/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt'),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          const deliveryFee = 5.0;
          final total = state.total;
          final finalTotal = total + deliveryFee;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Purchased Items:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // قائمة المنتجات
                ...state.items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('${item.name} × ${item.count}')),
                        Text('\$${item.totalPrice.toStringAsFixed(2)}'),
                      ],
                    ),
                  );
                }).toList(),

                const Divider(height: 40, thickness: 1),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 16)),
                    Text('\$${total.toStringAsFixed(2)}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Delivery Fee', style: TextStyle(fontSize: 16)),
                    const Text('\$5.00'),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Final Total',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${finalTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                KIconButton(
                  onTap: () async {
                    final totalAmount = finalTotal.toStringAsFixed(2);

                    final response = await http.post(
                      Uri.parse('${ApiEndPoints.baseUrl}/create-paypal-order'),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonEncode({'amount': totalAmount}),
                    );

                    if (response.statusCode == 200) {
                      final data = jsonDecode(response.body);
                      final approvalUrl = data['links'].firstWhere(
                          (link) => link['rel'] == 'approve')['href'];

                      // open browser
                      launchUrl(Uri.parse(approvalUrl),
                          mode: LaunchMode.externalApplication);
                    } else {}
                  },
                  finalTotal: finalTotal,
                  image: KImages.payPal,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
