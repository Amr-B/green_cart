import 'package:flutter/material.dart';
import 'package:green_cart/features/screens/home/widgets/category_item.dart';
import 'package:green_cart/features/screens/home/widgets/grocery_item.dart';
import 'package:green_cart/features/utils/images.dart';

import 'widgets/custom_home_appbar.dart' show CustomAppBar;
import 'widgets/home_carousel.dart';
import 'widgets/see_all_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // > appbar
            CustomAppBar(),
            // > carousel slider
            const HomeCarouselSlider(),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // > categories + see all row
                  KSeeAllCategories(),
                  const SizedBox(height: 10),

                  // > circular categories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KCircularCategoryItem(
                        onTap: () {},
                        title: 'Vegetables',
                        image: KImages.vegetables,
                      ),
                      KCircularCategoryItem(
                        onTap: () {},
                        title: 'Fruits',
                        image: KImages.fruits,
                      ),
                      KCircularCategoryItem(
                        onTap: () {},
                        title: 'Dairy',
                        image: KImages.dairy,
                      ),
                      KCircularCategoryItem(
                        onTap: () {},
                        title: 'Meat',
                        image: KImages.meat,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // > Grid of grocery items
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.74,
                    children: const [
                      GroceryItemCard(
                        imagePath: KImages.potatos,
                        title: 'Potatoes',
                        subtitle: 'Green Groceries',
                        price: '5.99',
                      ),
                      GroceryItemCard(
                        imagePath: KImages.fruits,
                        title: 'Bananas',
                        subtitle: 'Fresh Fruits',
                        price: '3.49',
                      ),
                      GroceryItemCard(
                        imagePath: KImages.vegetables,
                        title: 'Tomatoes',
                        subtitle: 'Organic Farm',
                        price: '2.89',
                      ),
                      GroceryItemCard(
                        imagePath: KImages.dairy,
                        title: 'Cheese',
                        subtitle: 'Dairy Products',
                        price: '4.50',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
