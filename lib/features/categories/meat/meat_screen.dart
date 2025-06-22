import 'package:flutter/material.dart';
import 'package:green_cart/common/default_appBar.dart';
import 'package:green_cart/data/data_provider.dart';
import 'package:green_cart/features/presentation/details/product_details_screen.dart';
import 'package:green_cart/config/themes/colors.dart';
import 'package:green_cart/data/models/categories/meat_model.dart';

import '../../presentation/home/widgets/grocery_item.dart';
import '../../../config/animations/animations.dart';

class MeatScreen extends StatefulWidget {
  const MeatScreen({super.key});

  @override
  State<MeatScreen> createState() => _MeatScreenState();
}

class _MeatScreenState extends State<MeatScreen> {
  late Future<List<MeatModel>> _futureMeat;
  @override
  void initState() {
    super.initState();
    _futureMeat = DataProviders.fetchMeatCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: KAppBar(
        title: 'Meat',
        useDefaultBackground: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<MeatModel>>(
          future: _futureMeat,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Dairy found.'));
            }

            final dairy = snapshot.data!;
            return GridView.builder(
              itemCount: dairy.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.74,
              ),
              itemBuilder: (context, index) {
                final item = dairy[index];
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
                          category: 'meat',
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
