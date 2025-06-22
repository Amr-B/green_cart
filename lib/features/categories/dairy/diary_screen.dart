import 'package:flutter/material.dart';
import 'package:green_cart/data/data_provider.dart';
import 'package:green_cart/features/home/widgets/grocery_item.dart';
import 'package:green_cart/features/product_details/product_details_screen.dart';
import 'package:green_cart/features/utils/animations.dart';
import 'package:green_cart/features/utils/colors.dart';
import 'package:green_cart/models/categories/dairy_model.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late Future<List<DairyModel>> _futureDairy;

  @override
  void initState() {
    super.initState();
    _futureDairy = DataProviders.fetchDairyCategory();
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
          'Dairy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<DairyModel>>(
          future: _futureDairy,
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
                          category: 'dairy',
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
