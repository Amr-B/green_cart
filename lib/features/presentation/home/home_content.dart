import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_cart/data/viewmodels/home/home_viewmodel.dart';
import 'package:green_cart/features/categories/dairy/diary_screen.dart';
import 'package:green_cart/features/categories/fruits/fruits_screen.dart';
import 'package:green_cart/features/categories/meat/meat_screen.dart';
import 'package:green_cart/features/categories/vegetables/vegetables_screen.dart';
import 'package:green_cart/features/presentation/home/widgets/category_item.dart';
import 'package:green_cart/features/presentation/home/widgets/custom_home_appbar.dart';
import 'package:green_cart/features/presentation/home/widgets/grocery_item.dart';
import 'package:green_cart/features/presentation/home/widgets/home_carousel.dart';
import 'package:green_cart/features/presentation/home/widgets/see_all_categories.dart';
import 'package:green_cart/features/presentation/details/product_details_screen.dart';
import 'package:green_cart/config/animations/animations.dart';
import 'package:green_cart/config/strings/images.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel()..fetchGroceries(),
      child: Consumer<HomeViewModel>(
        builder: (context, vm, child) {
          return RefreshIndicator(
            onRefresh: vm.fetchGroceries,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                              onTap: () => Navigator.push(
                                context,
                                CustomPageRoute(child: VegetablesScreen()),
                              ),
                              title: 'Vegetables',
                              image: KImages.vegetables,
                            ),
                            KCircularCategoryItem(
                              onTap: () => Navigator.push(
                                context,
                                CustomPageRoute(child: FruitsScreen()),
                              ),
                              title: 'Fruits',
                              image: KImages.fruits,
                            ),
                            KCircularCategoryItem(
                              onTap: () => Navigator.push(
                                context,
                                CustomPageRoute(child: DiaryScreen()),
                              ),
                              title: 'Dairy',
                              image: KImages.dairy,
                            ),
                            KCircularCategoryItem(
                              onTap: () => Navigator.push(
                                context,
                                CustomPageRoute(child: MeatScreen()),
                              ),
                              title: 'Meat',
                              image: KImages.meat,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // > groceries grid
                        if (vm.isLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (vm.error != null)
                          Center(child: Text("Error: ${vm.error}"))
                        else if (vm.groceries.isEmpty)
                          const Center(child: Text("No groceries found"))
                        else
                          GridView.builder(
                            itemCount: vm.groceries.length,
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
                              final item = vm.groceries[index];
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
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
