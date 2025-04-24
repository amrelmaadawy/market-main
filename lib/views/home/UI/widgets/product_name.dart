import 'package:flutter/material.dart';

class ProductName extends StatelessWidget {
  const ProductName({
    super.key,
    required this.productName,
    required this.onPressed,
    required this.isFave,
  });
  final String productName;
  final void Function() onPressed;
  final bool isFave;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          productName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.favorite,
              color:isFave? Colors.red:Colors.grey[600],
            )),
      ],
    );
  }
}
