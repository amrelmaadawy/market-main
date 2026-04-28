import 'package:app/core/app_colors.dart';
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
    required this.onPaymentSuccess,
    required this.isFave,
  });
  final ProductModel products;
  final void Function() onPressed;
  final void Function() onPaymentSuccess;
  final bool isFave;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(
                      onPaymentSuccess: onPaymentSuccess,
                      product: products,
                      onTap: onPressed,
                      isFave: isFave,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: OffersProduct(
                offer: products.sale ?? '10',
                imageUrl: products.imageUrl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductName(
                    isFave: isFave,
                    onPressed: onPressed,
                    productName: products.productName ?? 'name',
                  ),
                  const SizedBox(height: 8),
                  ProductPrice(
                    onPaymentSuccess: onPaymentSuccess,
                    oldPrice: products.oldPrice ?? '11',
                    newPrice: products.price ?? '11',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
