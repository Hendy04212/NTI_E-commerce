import 'package:ecommerce_shop/core/helper/my_validator.dart';
import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/widgets/custom_form_field.dart';
import 'package:ecommerce_shop/features/profile/widget/Custom_Circle_Avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecommerce_shop/core/widgets/custom_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullNameController.text = prefs.getString('userFullName') ?? '';
      phoneController.text = prefs.getString('userPhone') ?? '';
    });
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userFullName', fullNameController.text.trim());
    await prefs.setString('userPhone', phoneController.text.trim());

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile saved successfully!'),
          backgroundColor: Color(0xFFF83758),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context, true); // Return true to indicate data was saved
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              CustomCircleAvatar(showBlueBadge: true),
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
                onPressed: _saveData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
