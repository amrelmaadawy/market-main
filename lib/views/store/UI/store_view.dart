import 'package:app/core/app_colors.dart';
import 'package:app/core/components/list_of_products.dart';

import 'package:app/views/home/UI/widgets/search_form_feild.dart';
import 'package:flutter/material.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController storeSearchController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Center(
            child: Text('Welcome to our store',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kBlackColor,
                )),
          ),
          const SizedBox(
            height: 16,
          ),
          SearchFormField(searchController: storeSearchController,onPressed: (){},),
          const SizedBox(height: 16),
          const SizedBox(
            height: 16,
          ),
          const ListOfProducts()
        ],
      ),
    );
  }
}
