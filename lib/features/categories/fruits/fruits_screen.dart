import 'package:flutter/material.dart';
import 'package:green_cart/data/data_provider.dart';
import 'package:green_cart/features/home/widgets/grocery_item.dart';
import 'package:green_cart/features/product_details/product_details_screen.dart';
import 'package:green_cart/features/utils/animations.dart';
import 'package:green_cart/features/utils/colors.dart';
import 'package:green_cart/models/categories/fruits_model.dart';

class FruitsScreen extends StatefulWidget {
  const FruitsScreen({super.key});

  @override
  State<FruitsScreen> createState() => _FruitsScreenState();
}

class _FruitsScreenState extends State<FruitsScreen> {
  late Future<List<FruitsModel>> _futureFruits;

  @override
  void initState() {
    super.initState();
    _futureFruits = DataProviders.fetchFruitsCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: AppBar(
        surfaceTintColor: KColors.background,
        foregroundColor: KColors.dGreen,
        backgroundColor: KColors.background,
        centerTitle: true,
        title: const Text(
          'Fruits',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<FruitsModel>>(
          future: _futureFruits,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Fruits found.'));
            }

            final vegetables = snapshot.data!;
            return GridView.builder(
              itemCount: vegetables.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.74,
              ),
              itemBuilder: (context, index) {
                final item = vegetables[index];
                return GroceryItemCard(
                  imagePath: item.image,
                  title: item.name,
                  subtitle: item.companyName,
                  price: item.price.toString(),
                  onTap: () {
                    Navigator.push(
                      context,
                      CustomPageRoute(
                        child: ProductDetailsScreen(
                          productId: item.id,
                          category: 'fruits',
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
