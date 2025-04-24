import 'package:app/core/shimmer/shimmer_product_item.dart';
import 'package:flutter/material.dart';

class ShimmerListOfProduct extends StatelessWidget {
  const ShimmerListOfProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ShimmerProductItem();
                },
                itemCount: 5,
                shrinkWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
