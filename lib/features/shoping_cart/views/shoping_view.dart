
import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/core/widgets/custom_categories_section.dart';
import 'package:ecommerce_shop/core/widgets/custom_search_bar.dart';
import 'package:ecommerce_shop/features/shoping_cart/views/recent_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ShopingView extends StatelessWidget {
  const ShopingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.loginbtn,
          borderRadius: BorderRadius.circular(40),
        ),
        child: SvgPicture.asset(
          AppAssets.bag,
          width: 32,
          height: 32,
          fit: BoxFit.scaleDown,
        ),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomAppBar(),
            CustomSearchBar(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'All Featured',
                  style: AppTextStyle.allFeathureStyle,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomCategoriesSection(),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Products',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  height: 22 / 18,
                  letterSpacing: 0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RecentProducts()
          ],
        ),
      ),
    );
  }
}
