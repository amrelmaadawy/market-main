import 'package:dio/dio.dart';

class DioServises {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://fakestoreapi.com/"));

  Future<Response> getData(String path) async {
    return _dio.get(path);
  }

  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return _dio.post(path, data: data);
  }

  Future<Response> patchData(String path, Map<String, dynamic> data) async {
    return _dio.patch(path, data: data);
  }

  Future<Response> deletData(String path) async {
    return _dio.delete(path);
  }
}
