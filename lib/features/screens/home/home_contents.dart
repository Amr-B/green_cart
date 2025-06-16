import 'package:flutter/material.dart';
import 'package:green_cart/features/screens/home/widgets/category_item.dart';
import 'package:green_cart/features/screens/home/widgets/custom_home_appbar.dart';
import 'package:green_cart/features/screens/home/widgets/grocery_item.dart';
import 'package:green_cart/features/screens/home/widgets/home_carousel.dart';
import 'package:green_cart/features/screens/home/widgets/see_all_categories.dart';
import 'package:green_cart/features/screens/product_details/product_details_screen.dart';
import 'package:green_cart/features/utils/animations.dart';
import 'package:green_cart/features/utils/images.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.74,
                  children: [
                    GroceryItemCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            child: ProductDetailsScreen(),
                          ),
                        );
                      },
                      imagePath: KImages.potatos,
                      title: 'Potatoes',
                      subtitle: 'Green Groceries',
                      price: '5.99',
                    ),
                    GroceryItemCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            child: ProductDetailsScreen(),
                          ),
                        );
                      },
                      imagePath: KImages.fruits,
                      title: 'Bananas',
                      subtitle: 'Fresh Fruits',
                      price: '3.49',
                    ),
                    GroceryItemCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            child: ProductDetailsScreen(),
                          ),
                        );
                      },
                      imagePath: KImages.vegetables,
                      title: 'Tomatoes',
                      subtitle: 'Organic Farm',
                      price: '2.89',
                    ),
                    GroceryItemCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            child: ProductDetailsScreen(),
                          ),
                        );
                      },
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
    );
  }
}
