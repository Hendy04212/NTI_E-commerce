import 'dart:io';

import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCircleAvatar extends StatefulWidget {
  const CustomCircleAvatar({super.key});

  @override
  _CustomCircleAvatarState createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
  String? imagePath;
  final ImagePicker _picker = ImagePicker();
  void _saveImagePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userImagePath', path);
    setState(() {
      imagePath = path;
    });
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _saveImagePath(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 50,
        child: GestureDetector(
          onTap: _pickImage,
          child: ClipOval(
            child: imagePath != null
                ? Image.file(File(imagePath!),
                    fit: BoxFit.cover, width: 200, height: 200)
                : Image.asset(AppAssets.defaultImage),
          ),
        ),
      ),
    );
  }
}
