import 'package:ecommerce_shop/core/helper/my_validator.dart';
import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/widgets/custom_form_field.dart';
import 'package:ecommerce_shop/features/profile/widget/Custom_Circle_Avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecommerce_shop/core/widgets/custom_btn.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            AppAssets.arrowback,
            height: 11,
            width: 11,
            fit: BoxFit.scaleDown,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: AppTextStyle.appbarstylr,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomCircleAvatar(),
              SizedBox(height: 30),
              CustomFormField(
                hintText: 'Full Name',
                prefixIcon: SvgPicture.asset(
                  AppAssets.user,
                  fit: BoxFit.scaleDown,
                ),
                controller: fullNameController,
                validator: requiredValidator,
              ),
              SizedBox(height: 20),
              CustomFormField(
                hintText: 'Phone',
                prefixIcon: SvgPicture.asset(
                  AppAssets.call,
                  fit: BoxFit.scaleDown,
                ),
                controller: phoneController,
                validator: phoneValidator,
              ),
              SizedBox(height: 30),
              CustomBtn(
                text: 'Save',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
