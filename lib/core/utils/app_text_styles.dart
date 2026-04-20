import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static const TextStyle onbordingskip = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.onboardingtext,
  );
  static const TextStyle onbordingText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.onboardingtext,
  );
  static const TextStyle onbordingSupText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.onboardingSuptext,
  );
  static const TextStyle onbordingbtn = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.onboardingbtn,
  );
  static const TextStyle getStarttitle = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w600,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.white,
  );
  static const TextStyle getStartSuptitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.getStratedcolor,
  );
  static const TextStyle loginTitel = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.onboardingtext,
  );
  static const TextStyle logInStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.white,
  );
  static const TextStyle regesterStyly = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.loginbtn,
  );
  static const TextStyle searchTextStyly = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.searchtext,
  );
  static const TextStyle textAppbar = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.appbartext,
  );
  static const TextStyle allFeathureStyle = TextStyle(
    fontSize: 20,
    height: 22 / 18,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.onboardingtext,
  );
  static const TextStyle categoryText = TextStyle(
    fontSize: 10,
    height: 16 / 10,
    letterSpacing: 0.0,
    textBaseline: TextBaseline.alphabetic,
    fontWeight: FontWeight.normal,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.onboardingtext,
  );
  static const TextStyle onboardText = TextStyle(
    fontSize: 10,
    height: 24 / 14,
    letterSpacing: 0.02,
    fontWeight: FontWeight.normal,
    fontFamily: AppAssets.fontfamily,
    color: AppColors.onboardingtext,
  );
  static const TextStyle reviwStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 16 / 10,
    letterSpacing: 0,
    color: AppColors.reviewcolor,
  );
  static const TextStyle priceStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0,
    color: AppColors.onboardingtext,
  );
  static const TextStyle nameStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 16 / 12,
    letterSpacing: 0,
    color: AppColors.onboardingtext,
  );
  static const TextStyle discStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 16 / 10,
    letterSpacing: 0,
    color: AppColors.onboardingtext,
  );
  static const TextStyle catrbtn = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 15,
    height: 24 / 15,
    letterSpacing: 0.5,
    color: AppColors.white,
  );
  static const TextStyle appbarstylr = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 22 / 18,
    letterSpacing: 0.0,
    color: AppColors.onboardingtext,
  );
  static const TextStyle regular9 = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
  static TextStyle light20({Color color = Colors.black}) =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: color);
  static TextStyle light10({Color color = Colors.black}) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: color,
    fontFamily: AppAssets.fontfamily,
  );
  static TextStyle customTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: -0.005,
    textBaseline: TextBaseline.alphabetic,
    color: AppColors.white,
  );
}
