import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final List<String> carouselImages = const [
    'assets/images/banners/banner-1.jpg',
    'assets/images/banners/banner-2.jpg',
    'assets/images/banners/banner-3.jpg',
    'assets/images/banners/banner-4.jpg',
    'assets/images/banners/banner-5.jpg',
    'assets/images/banners/banner-6.jpg',
    'assets/images/banners/banner-7.jpg',
  ];

  final CarouselSliderController _controller = CarouselSliderController();

  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    const double bannerHeight = 160;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 90,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF003d29),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            CarouselSlider.builder(
              carouselController: _controller,
              itemCount: carouselImages.length,
              itemBuilder: (context, index, realIndex) {
                return CarouselImageItem(imagePath: carouselImages[index]);
              },
              options: CarouselOptions(
                height: bannerHeight,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  setState(() => _activeIndex = index);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: _activeIndex,
          count: carouselImages.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6,
            dotWidth: 10,
            activeDotColor: Color(0xFF003d29),
            dotColor: Colors.grey.shade400,
          ),
          onDotClicked: (index) {
            _controller.animateToPage(index);
          },
        ),
      ],
    );
  }
}

class CarouselImageItem extends StatelessWidget {
  final String imagePath;
  const CarouselImageItem({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
