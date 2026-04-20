import 'package:ecommerce_shop/core/helper/my_navigator.dart';
import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/features/auth/views/login_view.dart';
import 'package:ecommerce_shop/features/myfavorite/views/my_fav_view.dart';
import 'package:ecommerce_shop/features/order_details/views/Orders_View.dart';
import 'package:ecommerce_shop/features/profile/view/my_profile.dart';
import 'package:ecommerce_shop/features/profile/widget/Custom_Circle_Avatar.dart';
import 'package:ecommerce_shop/features/profile/widget/Profile_Menu_Item.dart';
import 'package:ecommerce_shop/features/shoping_cart/views/cart_view.dart';
import 'package:ecommerce_shop/features/setting/views/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        centerTitle: true,
        title: Text(
          'Profile',
          style: AppTextStyle.appbarstylr,
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
         MyNavigator.goTo(screen: CartView());
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.loginbtn,
            borderRadius: BorderRadius.circular(40),
          ),
          child: SvgPicture.asset(
            AppAssets.bag2,
            width: 32,
            height: 32,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(23),
        child: Column(
          spacing: 30,
          children: [
            CustomCircleAvatar(),
            ProfileMenuItem(
              icon: SvgPicture.asset(AppAssets.profile),
              text: 'My Profile',
              onTap: () {
               MyNavigator.goTo(screen: MyProfile());
              },
            ),
            ProfileMenuItem(
              icon: SvgPicture.asset(AppAssets.bag2),
              text: 'My Orders',
              onTap: () {
                MyNavigator.goTo(screen: OrdersView());
              },
            ),
            ProfileMenuItem(
              icon: SvgPicture.asset(AppAssets.fav),
              text: 'My Favorites',
              onTap: () {
              MyNavigator.goTo(screen: MyFavView());
              },
            ),
            ProfileMenuItem(
              icon: SvgPicture.asset(AppAssets.sitting),
              text: 'Settings',
              onTap: () {
               MyNavigator.goTo(screen: SettingsView());
              },
            ),
            Divider(
              thickness: 1,
              color: AppColors.loginbtn,
            ),
            ProfileMenuItem(
              icon: SvgPicture.asset(AppAssets.logout),
              text: 'Log Out',
              onTap: () {MyNavigator.goTo(screen: LoginView(),);},
            ),
          ],
        ),
      ),
    );
  }
}
