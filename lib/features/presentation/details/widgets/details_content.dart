// extracted widget: details_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cart/cubits/cart/cart_item_cubit.dart';
import 'package:green_cart/cubits/details/count_cubit.dart';
import 'package:green_cart/features/presentation/cart/cart_screen.dart';
import 'package:green_cart/common/back_appbar_button.dart';
import 'package:green_cart/common/button.dart';
import 'package:green_cart/features/presentation/details/widgets/price_and_rate.dart';
import 'package:green_cart/features/presentation/details/widgets/product_count.dart';
import 'package:green_cart/config/animations/animations.dart';

class ProductDetailsContent extends StatefulWidget {
  final dynamic product;
  final double screenHeight;

  const ProductDetailsContent({
    super.key,
    required this.product,
    required this.screenHeight,
  });

  @override
  State<ProductDetailsContent> createState() => _ProductDetailsContentState();
}

class _ProductDetailsContentState extends State<ProductDetailsContent> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final screenHeight = widget.screenHeight;

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: KBackAppBarButton(context),
              centerTitle: true,
              title: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // > product name
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 12),

                    // > price and rate
                    PriceRate(price: product.price),
                    SizedBox(height: 20),

                    // > count
                    ProductCount(
                      count: state.count,
                      onIncrement: () =>
                          context.read<ProductDetailsCubit>().increment(),
                      onDecrement: () =>
                          context.read<ProductDetailsCubit>().decrement(),
                    ),
                    SizedBox(height: 30),

                    // > Description
                    Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text('Description', style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(height: screenHeight * 0.25),

                    // > add to cart button
                    KButton(
                      screenHeight: screenHeight,
                      title:
                          'Add to cart - \$${state.totalPrice.toStringAsFixed(2)}',
                      onTap: () {
                        final cubit = context.read<CartCubit>();
                        final product = widget.product;
                        final state = context.read<ProductDetailsCubit>().state;

                        cubit.addItem(CartItem(
                          name: product.name,
                          image: product.image,
                          unitPrice: product.price.toDouble(),
                          count: state.count,
                        ));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} added to cart'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
