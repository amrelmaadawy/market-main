import 'package:equatable/equatable.dart';

class Purchase extends Equatable {
  final String? id;
  final String? userId;
  final bool? isBought;
  final DateTime? createdAt;
  final String? productId;

  const Purchase({
    this.id,
    this.userId,
    this.isBought,
    this.createdAt,
    this.productId,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
        id: json['id'] as String?,
        userId: json['user_id'] as String?,
        isBought: json['is_bought'] as bool?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        productId: json['product_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'is_bought': isBought,
        'created_at': createdAt?.toIso8601String(),
        'product_id': productId,
      };

  @override
  List<Object?> get props => [id, userId, isBought, createdAt, productId];
}
