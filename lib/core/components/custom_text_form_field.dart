import 'package:app/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild(
      {super.key,
      required this.lableText,
      required this.controller,
      required this.obscureText,
      required this.keyboardType,
      this.suffixIcon});
  final String lableText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your $lableText';
        }
        return null;
      },
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.kBordersideColor,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.kBordersideColor,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.kBordersideColor,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        labelText: lableText,
      ),
    );
  }
}
