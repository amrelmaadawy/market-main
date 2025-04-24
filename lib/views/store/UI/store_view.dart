import 'package:app/core/app_colors.dart';
import 'package:app/core/components/list_of_products.dart';
import 'package:app/views/home/UI/search_view.dart';

import 'package:app/views/home/UI/widgets/search_form_feild.dart';
import 'package:flutter/material.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  TextEditingController storeSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
          SearchFormField(
            searchController: storeSearchController,
            onPressed: () {
              if (storeSearchController.text.isNotEmpty) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchView(query: storeSearchController.text);
                }));
                storeSearchController.clear();
              }
            },
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 16,
          ),
          const ListOfProducts()
        ],
      ),
    );
  }

  @override
  void dispose() {
    storeSearchController.dispose();
    super.dispose();
  }
}
