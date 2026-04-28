import 'package:app/core/dio_servises.dart';
import 'package:app/core/dummy_data.dart';
import 'package:app/core/models/product_model/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<void> addToFavorite(String productId);
  Future<void> removeFromFavorite(String productId);
  Future<void> processPayment(String productId);
}

class ProductRepositoryImpl implements ProductRepository {
  final DioServises dioServises;

  ProductRepositoryImpl({required this.dioServises});

  @override
  Future<List<ProductModel>> getProducts() async {
    // In the future, this will be: return await dioServises.getData('products');
    await Future.delayed(const Duration(milliseconds: 500)); // Mock network
    List<ProductModel> products = [];
    for (var product in dummyProducts) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }

  @override
  Future<void> addToFavorite(String productId) async {
    // Mock API call to add to favorite
    await Future.delayed(const Duration(seconds: 1)); 
  }

  @override
  Future<void> removeFromFavorite(String productId) async {
    // Mock API call to remove from favorite
    await Future.delayed(const Duration(seconds: 1)); 
  }

  @override
  Future<void> processPayment(String productId) async {
    // Mock API call to process payment
    await Future.delayed(const Duration(seconds: 1)); 
  }
}
