import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCategoriesSection extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onCategoryTap;

  final List<Map<String, String>> categories = const [
    {'icon': 'assets/images/Bueaty.png', 'name': 'Beauty'},
    {'icon': 'assets/images/fashion.png', 'name': 'Fashion'},
    {'icon': 'assets/images/Kids.png', 'name': 'Kids'},
    {'icon': 'assets/images/men.png', 'name': 'Men'},
    {'icon': 'assets/images/women.png', 'name': 'Women'},
  ];

  const CustomCategoriesSection({
    super.key,
    required this.selectedIndex,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onCategoryTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated icon container
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    width: isSelected ? 72 : 60,
                    height: isSelected ? 72 : 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(isSelected ? 22 : 30),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.loginbtn
                            : Colors.transparent,
                        width: isSelected ? 2.5 : 0,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.loginbtn.withOpacity(0.3),
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 6,
                                spreadRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                      color: isSelected
                          ? AppColors.loginbtn.withOpacity(0.08)
                          : Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(isSelected ? 20 : 28),
                      child: Image.asset(
                        category['icon']!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Category name with animated style
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: isSelected
                        ? AppTextStyle.categoryText.copyWith(
                            color: AppColors.loginbtn,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          )
                        : AppTextStyle.categoryText,
                    child: Text(
                      category['name']!,
                      textAlign: TextAlign.center,
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
