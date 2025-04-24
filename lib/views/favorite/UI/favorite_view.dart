import 'package:app/core/app_colors.dart';
import 'package:app/core/components/list_of_products.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: const [
          Center(
            child: Text('Your Favorite Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kBlackColor,
                )),
          ),
          SizedBox(
            height: 16,
          ),
          ListOfProducts(isFaveoriteView: true,)
        ],
      ),
    );
  }
}
