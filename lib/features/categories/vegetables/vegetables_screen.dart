import 'package:flutter/material.dart';
import 'package:green_cart/data/data_provider.dart';
import 'package:green_cart/features/presentation/home/widgets/grocery_item.dart';
import 'package:green_cart/features/presentation/details/product_details_screen.dart';
import 'package:green_cart/config/animations/animations.dart';
import 'package:green_cart/config/themes/colors.dart';
import 'package:green_cart/data/models/categories/vegetables_model.dart';

import '../../../common/default_appBar.dart';

class VegetablesScreen extends StatefulWidget {
  const VegetablesScreen({super.key});

  @override
  State<VegetablesScreen> createState() => _VegetablesScreenState();
}

class _VegetablesScreenState extends State<VegetablesScreen> {
  late Future<List<VegetablesCatModel>> _futureVegetables;

  @override
  void initState() {
    super.initState();
    _futureVegetables = DataProviders.fetchVegetablesCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: KAppBar(
        title: 'Vegetables',
        useDefaultBackground: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<VegetablesCatModel>>(
          future: _futureVegetables,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No vegetables found.'));
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
                          category: 'vegetables',
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
