import 'package:app/core/components/list_of_products.dart';
import 'package:app/core/functions/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Search Results'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [ListOfProducts(query: query,)],
          ),
        ),
      ),
    );
  }
}
