import 'package:dio/dio.dart';
import 'package:app/core/models/product_model/product_model.dart';

void main() async {
  final dio = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com/"));
  try {
    Response response = await dio.get("products");
    print('Fetched \${response.data.length} products');
    for (var product in response.data) {
       // Simulate parsing
       try {
           var model = ProductModel.fromJson(product);
           print('Parsed product: \${model.productName}');
       } catch(e) {
           print('Parsing error: $e');
       }
    }
    print('Done!');
  } catch (e) {
    print('Error: $e');
  }
}
