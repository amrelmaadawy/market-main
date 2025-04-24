import 'package:app/core/app_colors.dart';
import 'package:app/core/components/list_of_products.dart';
import 'package:app/views/home/UI/search_view.dart';
import 'package:app/views/home/UI/widgets/categories_list.dart';

import 'package:app/views/home/UI/widgets/search_form_feild.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController mainSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          SearchFormField(
            searchController: mainSearchController,
            onPressed: () {
              if (mainSearchController.text.isNotEmpty) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchView(query: mainSearchController.text);
                }));
              }
            },
          ),
          const SizedBox(height: 16),
          Image.asset('assets/images/buy.jpg'),
          const SizedBox(height: 16),
          const Text(
            'Popular Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.kBlackColor,
            ),
          ),
          const SizedBox(height: 16),
          const CategoriesList(),
          const SizedBox(
            height: 16,
          ),
          const Text('Recntly products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.kBlackColor,
              )),
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
    mainSearchController.dispose();
    super.dispose();
  }
}
