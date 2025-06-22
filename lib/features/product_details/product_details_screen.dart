// main screen file: product_details_screen.dart
import 'package:flutter/material.dart';
import 'package:green_cart/data/data_provider.dart';
import 'package:green_cart/features/product_details/widgets/details_content.dart';
import 'package:green_cart/features/utils/colors.dart';
import 'package:green_cart/features/utils/responsive.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final String category;
  const ProductDetailsScreen({
    super.key,
    required this.productId,
    required this.category,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Future<dynamic> _futureProduct;

  @override
  void initState() {
    super.initState();
    _futureProduct = DataProviders.fetchDynamicProductById(
      widget.category,
      widget.productId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = Responsive.screenHeight(context);

    return Scaffold(
      backgroundColor: KColors.background,
      body: FutureBuilder(
        future: _futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error : \${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Product not found'));
          }
          return ProductDetailsContent(
              product: snapshot.data!, screenHeight: screenHeight);
        },
      ),
    );
  }
}
