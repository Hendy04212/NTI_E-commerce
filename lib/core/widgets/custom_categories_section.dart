import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomCategoriesSection extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'icon': 'assets/images/Bueaty.png', 'name': 'Beauty'},
    {'icon': 'assets/images/fashion.png', 'name': 'Fashion'},
    {'icon': 'assets/images/Kids.png', 'name': 'Kids'},
    {'icon': 'assets/images/men.png', 'name': 'Men'},
    {'icon': 'assets/images/women.png', 'name': 'Women'},
  ];

   CustomCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Image.asset(
                    category['icon']!,
                    width: 40,
                    height: 4,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 5),
                Text(category['name']!,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.categoryText),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
