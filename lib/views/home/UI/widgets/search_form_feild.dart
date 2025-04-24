import 'package:app/core/app_colors.dart';
import 'package:app/core/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SearchFormField extends StatelessWidget {
  const SearchFormField({
    super.key,
    required this.searchController,
    required this.onPressed,
  });

  final TextEditingController searchController;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormFeild(
        suffixIcon: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Icon(
            Icons.search,
            color: AppColors.kWhiteColor,
          ),
        ),
        lableText: 'Search in market',
        controller: searchController,
        obscureText: false,
        keyboardType: TextInputType.text);
  }
}
