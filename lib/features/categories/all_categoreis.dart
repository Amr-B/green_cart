import 'package:flutter/material.dart';
import 'package:green_cart/features/categories/dairy/diary_screen.dart';
import 'package:green_cart/features/categories/fruits/fruits_screen.dart';
import 'package:green_cart/features/categories/meat/meat_screen.dart';
import 'package:green_cart/features/categories/vegetables/vegetables_screen.dart';
import 'package:green_cart/features/categories/widgets/category_container.dart';
import 'package:green_cart/features/utils/animations.dart';
import 'package:green_cart/features/utils/colors.dart';
import 'package:green_cart/features/utils/images.dart';
import 'package:green_cart/features/utils/responsive.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = Responsive.screenWidth(context);
    final screenHeight = Responsive.screenHeight(context);
    return Scaffold(
      backgroundColor: KColors.background,
      appBar: AppBar(
        surfaceTintColor: KColors.background,
        foregroundColor: KColors.dGreen,
        backgroundColor: KColors.background,
        centerTitle: true,
        title: Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            children: [
              // > vegetables
              KCategoryContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      child: VegetablesScreen(),
                    ),
                  );
                },
                title: 'Vegetables',
                itemsCount: '25',
                image: KImages.catVegetables,
                color: KColors.tealGreen,
                screenHeight: screenHeight,
                right: -40,
                bottom: -40,
                imageHeight: screenHeight * 0.22,
              ),
              SizedBox(height: 20),

              // > fruits
              KCategoryContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      child: FruitsScreen(),
                    ),
                  );
                },
                title: 'Fruits',
                itemsCount: '25',
                image: KImages.catFruits,
                color: KColors.orangeYellow,
                screenHeight: screenHeight,
                right: -40,
                bottom: -40,
                imageHeight: screenHeight * 0.22,
              ),

              // > diary
              SizedBox(height: 20),
              KCategoryContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      child: DiaryScreen(),
                    ),
                  );
                },
                title: 'Diary',
                itemsCount: '25',
                image: KImages.catDairy,
                color: KColors.lBlue,
                screenHeight: screenHeight,
                right: -10,
                bottom: -10,
                imageHeight: screenHeight * 0.22,
              ),

              // > meet
              SizedBox(height: 20),
              KCategoryContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      child: MeatScreen(),
                    ),
                  );
                },
                title: 'Meat',
                itemsCount: '25',
                image: KImages.catMeat,
                color: KColors.dRed,
                screenHeight: screenHeight,
                right: -40,
                bottom: -50,
                imageHeight: screenHeight * 0.22,
              ),
              // > snacks
              SizedBox(height: 20),
              KCategoryContainer(
                title: 'Snacks',
                itemsCount: '25',
                image: KImages.catSnacks,
                color: KColors.orangeYellow,
                screenHeight: screenHeight,
                right: -40,
                bottom: -60,
                imageHeight: screenHeight * 0.22,
              ),
              SizedBox(height: 20),

              // > backery
              KCategoryContainer(
                title: 'Bakery',
                itemsCount: '25',
                image: KImages.catBakery,
                color: KColors.brown,
                screenHeight: screenHeight,
                right: -40,
                bottom: -40,
                imageHeight: screenHeight * 0.18,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
