import 'package:flutter/material.dart';
import 'package:green_cart/data/data_provider.dart';
import 'package:green_cart/features/categories/dairy/diary_screen.dart';
import 'package:green_cart/features/categories/fruits/fruits_screen.dart';
import 'package:green_cart/features/categories/meat/meat_screen.dart';
import 'package:green_cart/features/presentation/home/widgets/category_item.dart';
import 'package:green_cart/features/presentation/home/widgets/custom_home_appbar.dart';
import 'package:green_cart/features/presentation/home/widgets/grocery_item.dart';
import 'package:green_cart/features/presentation/home/widgets/home_carousel.dart';
import 'package:green_cart/features/presentation/home/widgets/see_all_categories.dart';
import 'package:green_cart/features/presentation/details/product_details_screen.dart';
import 'package:green_cart/features/categories/vegetables/vegetables_screen.dart';
import 'package:green_cart/config/animations/animations.dart';
import 'package:green_cart/config/strings/images.dart';
import 'package:green_cart/data/models/categories/new_groceries.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late Future<List<NewGroceriesModel>> _futureGroceries;

  @override
  void initState() {
    super.initState();
    _futureGroceries = DataProviders.fetchNewGroceries();
  }

  // > refresh data
  Future<void> _refreshData() async {
    setState(() {
      _futureGroceries = DataProviders.fetchNewGroceries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
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
                        onTap: () {
                          Navigator.push(
                            context,
                            CustomPageRoute(
                              child: VegetablesScreen(),
                            ),
                          );
                        },
                        title: 'Vegetables',
                        image: KImages.vegetables,
                      ),
                      KCircularCategoryItem(
                        onTap: () {
                          Navigator.push(
                            context,
                            CustomPageRoute(
                              child: FruitsScreen(),
                            ),
                          );
                        },
                        title: 'Fruits',
                        image: KImages.fruits,
                      ),
                      KCircularCategoryItem(
                        onTap: () {
                          Navigator.push(
                            context,
                            CustomPageRoute(
                              child: DiaryScreen(),
                            ),
                          );
                        },
                        title: 'Dairy',
                        image: KImages.dairy,
                      ),
                      KCircularCategoryItem(
                        onTap: () {
                          Navigator.push(
                            context,
                            CustomPageRoute(
                              child: MeatScreen(),
                            ),
                          );
                        },
                        title: 'Meat',
                        image: KImages.meat,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // > Grid of grocery items
                  FutureBuilder<List<NewGroceriesModel>>(
                    future: _futureGroceries,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No groceries found.'));
                      }
                      final groceries = snapshot.data!;
                      return GridView.builder(
                        itemCount: groceries.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.74,
                        ),
                        itemBuilder: (context, index) {
                          final item = groceries[index];
                          return GroceryItemCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                CustomPageRoute(
                                  child: ProductDetailsScreen(
                                    productId: item.id,
                                    category: 'groceries',
                                  ),
                                ),
                              );
                            },
                            imagePath: item.image,
                            title: item.name,
                            subtitle: item.companyName,
                            price: item.price.toString(),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
