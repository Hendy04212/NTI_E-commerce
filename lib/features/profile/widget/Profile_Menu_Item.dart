
import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenuItem extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: AppAssets.fontfamily,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SvgPicture.asset(
              AppAssets.arrowforward,
              width: 14,
              height: 14,
              fit: BoxFit.scaleDown,
              color: AppColors.categoryTextColor,
            )
          ],
        ),
      ),
    );
  }
}
