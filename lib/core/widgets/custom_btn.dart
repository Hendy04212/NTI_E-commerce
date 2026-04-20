// import '../utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';


class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, required this.text, required this.onPressed});
  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor:AppColors.loginbtn,
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text(
          text,
          style: AppTextStyle.logInStyle,
        ),
      ),
    );
  }
}
