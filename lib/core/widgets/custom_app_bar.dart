import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget  {
  const CustomAppBar({super.key});

  @override
 

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title:  SvgPicture.asset(
            AppAssets.logoAppBar,
            width: 38,
            height: 31,
            fit: BoxFit.scaleDown,
          ),
    );
  }
}