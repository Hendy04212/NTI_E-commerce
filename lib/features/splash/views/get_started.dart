import 'package:ecommerce_shop/core/helper/my_navigator.dart';
import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/features/auth/views/login_view.dart';
import 'package:ecommerce_shop/features/auth/views/register_view.dart';
import 'package:flutter/material.dart';
class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.getstarted,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.65),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "You want\n Authentic, here\n you go!",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.getStarttitle,
                ),
                SizedBox(height: 10),
                Text("Find it here, buy it now.",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.getStartSuptitle),
                SizedBox(height: 30),
                SizedBox(
                  width: 279,
                  child: ElevatedButton(
                    onPressed: () {
                     MyNavigator.goTo(screen: LoginView());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      backgroundColor: AppColors.loginbtn,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      "Login",
                      style: AppTextStyle.logInStyle,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 279,
                  child: OutlinedButton(
                    onPressed: () {
                      MyNavigator.goTo(screen: RegisterView());
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor:AppColors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      side: BorderSide(color: Colors.red),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      "Register",
                      style: AppTextStyle.regesterStyly,
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
