import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/utils/app_assets.dart';

class CustomPromoSlider extends StatefulWidget {
  const CustomPromoSlider({super.key});

  @override
  State<CustomPromoSlider> createState() => CustomPromoSliderState();
}

class CustomPromoSliderState extends State<CustomPromoSlider> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<Map<String, String>> sliderData = [
    {
      'image': 'assets/images/banner.png',
      'title': '50-40% OFF',
      'subtitle': 'Now in (product)\nAll colours',
      'buttonText': 'Shop Now'
    },
    {
      'image': 'assets/images/banner.png',
      'title': 'New Collection',
      'subtitle': 'Now in (product)\nAll colours',
      'buttonText': 'Shop Now'
    },
    {
      'image': 'assets/images/banner.png',
      'title': 'New Collection',
      'subtitle': 'Now in (product)\nAll colours',
      'buttonText': 'Shop Now'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 189,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: sliderData.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: 343,
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(item['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 16,
                        top: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title']!,
                              style: TextStyle(
                                  fontFamily: AppAssets.fontfamily,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              item['subtitle']!,
                              style: TextStyle(
                                  fontFamily: AppAssets.fontfamily,
                                  fontSize: 12,
                                  color: AppColors.white),
                            ),
                            SizedBox(height: 10),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(color: Colors.white, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Shop Now",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppAssets.fontfamily,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  SvgPicture.asset(
                                    'assets/icons/arrowback.svg',
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.scaleDown,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: sliderData.length,
            effect: WormEffect(
              dotHeight: 9,
              dotWidth: 9,
              activeDotColor: AppColors.activedottscolor,
              dotColor: AppColors.inactivdotcolor,
            )),
      ],
    );
  }
}
