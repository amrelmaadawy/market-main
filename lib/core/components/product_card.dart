import 'package:app/core/models/product_model/product_model.dart';
import 'package:app/views/home/UI/widgets/offers_product.dart';
import 'package:app/views/home/UI/widgets/product_name.dart';
import 'package:app/views/home/UI/widgets/product_price.dart';
import 'package:app/views/productDetails/UI/product_details.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.products,
    required this.onPressed,
  required this.isFave,
  });
  final ProductModel products;
  final void Function() onPressed;
 final bool isFave;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  ProductDetails(product: products,)));
      },
      child: Column(
        children: [
          OffersProduct(
            offer: products.sale ?? '10',
            imageUrl: products.imageUrl,
          ),
          SizedBox(
            height: 16,
          ),
          ProductName(
isFave: isFave,
            onPressed: onPressed,
            productName: products.productName ?? 'name',
          ),
          ProductPrice(
            oldPrice: products.oldPrice ?? '11',
            newPrice: products.price ?? '11',
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
