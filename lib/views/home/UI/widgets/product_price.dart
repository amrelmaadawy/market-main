import 'package:app/core/app_colors.dart';
import 'package:app/core/functions/snake_bar.dart';
import 'package:app/views/auth/UI/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.newPrice,
    required this.oldPrice,
    required this.onPaymentSuccess,
  });
  final String oldPrice;
  final String newPrice;
  final void Function() onPaymentSuccess;
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentView(
                    onPaymentSuccess: onPaymentSuccess,
                    onPaymentError: () {
                      snakeBar(context, 'payment Error', Colors.red);
                    },
                    price: double.parse(
                        newPrice), // Required: Total price (e.g., 100 for 100 EGP)
                  ),
                ),
              );
            },
            child: const Text(
              'Buy Now',
              style: TextStyle(color: AppColors.kWhiteColor),
            ))
      ],
    );
  }
}
