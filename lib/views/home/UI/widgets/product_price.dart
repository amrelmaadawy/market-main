import 'package:app/core/app_colors.dart';
import 'package:app/views/auth/UI/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.newPrice,
    required this.oldPrice,
  });
  final String oldPrice;
  final String newPrice;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              newPrice,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.kBlackColor,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              oldPrice,
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 16,
                color: AppColors.kGreyColor,
              ),
            ),
          ],
        ),
        CustomButton(
            onPressed: () {},
            child: const Text(
              'Buy Now',
              style: TextStyle(color: AppColors.kWhiteColor),
            ))
      ],
    );
  }
}
