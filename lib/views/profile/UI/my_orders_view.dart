import 'package:app/core/components/list_of_products.dart';
import 'package:app/core/functions/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context, 'My Orders'),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListOfProducts(
              shrinkWrap: false,
              physics: ScrollPhysics(),
            ),
          ),
        ));
  }
}
