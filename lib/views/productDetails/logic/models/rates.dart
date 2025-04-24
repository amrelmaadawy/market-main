import 'package:equatable/equatable.dart';

class Rates extends Equatable {
  final String? id;
  final DateTime? createdAt;
  final int? rates;
  final String? userId;
  final String? productId;

  const Rates({
    this.id,
    this.createdAt,
    this.rates,
    this.userId,
    this.productId,
  });

  factory Rates.fromJson(Map<String, dynamic> json) => Rates(
        id: json['id'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        rates: json['rates'] as int?,
        userId: json['user_id'] as String?,
        productId: json['product_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'rates': rates,
        'user_id': userId,
        'product_id': productId,
      };

  @override
  List<Object?> get props => [id, createdAt, rates, userId, productId];
}
