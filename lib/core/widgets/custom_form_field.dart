import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    required this.controller,
    required this.validator,
    this.obscureText = false,
  });

  final String hintText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final VoidCallback? onSuffixIconPressed;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 317,
      height: 55,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: onSuffixIconPressed,
                  child: suffixIcon,
                )
              : null,
          prefixIcon: prefixIcon,
          fillColor: const Color(0xFFF3F3F3),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF676767)),

          // ✅ إضافة هذا السطر لتقليل حجم الـ error message
          errorStyle: const TextStyle(height: 0),

          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFA8A8A9)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFA8A8A9)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFA8A8A9)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFA8A8A9)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
