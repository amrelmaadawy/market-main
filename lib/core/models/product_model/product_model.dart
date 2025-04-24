import 'package:equatable/equatable.dart';

import 'fave_product.dart';
import 'purchase.dart';

class ProductModel extends Equatable {
  final String? productId;
  final DateTime? createdAt;
  final String? productName;
  final String? price;
  final String? oldPrice;
  final String? sale;
  final String? description;
  final String? category;
  final dynamic imageUrl;
  final List<FaveProduct>? faveProduct;
  final List<Purchase>? purchase;

  const ProductModel({
    this.productId,
    this.createdAt,
    this.productName,
    this.price,
    this.oldPrice,
    this.sale,
    this.description,
    this.category,
    this.imageUrl,
    this.faveProduct,
    this.purchase,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productId: json['product_id'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        productName: json['product_name'] as String?,
        price: json['price'] as String?,
        oldPrice: json['old_price'] as String?,
        sale: json['sale'] as String?,
        description: json['description'] as String?,
        category: json['category'] as String?,
        imageUrl: json['image_url'] as dynamic,
        faveProduct: (json['fave_product'] as List<dynamic>?)
            ?.map((e) => FaveProduct.fromJson(e as Map<String, dynamic>))
            .toList(),
        purchase: (json['purchase'] as List<dynamic>?)
            ?.map((e) => Purchase.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'created_at': createdAt?.toIso8601String(),
        'product_name': productName,
        'price': price,
        'old_price': oldPrice,
        'sale': sale,
        'description': description,
        'category': category,
        'image_url': imageUrl,
        'fave_product': faveProduct?.map((e) => e.toJson()).toList(),
        'purchase': purchase?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      productId,
      createdAt,
      productName,
      price,
      oldPrice,
      sale,
      description,
      category,
      imageUrl,
      faveProduct,
      purchase,
    ];
  }
}
