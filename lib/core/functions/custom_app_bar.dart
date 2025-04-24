import 'package:app/core/app_colors.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, String text) {
  return AppBar(
    backgroundColor: AppColors.kPrimaryColor,
    title: Text(
      text,
      style: const TextStyle(color: AppColors.kWhiteColor),
    ),
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: AppColors.kWhiteColor,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
