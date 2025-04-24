import 'package:app/core/components/list_of_products.dart';
import 'package:app/core/functions/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, category),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              ListOfProducts(category: category,)
              ],
          ),
        ),
      ),
    );
  }
}
