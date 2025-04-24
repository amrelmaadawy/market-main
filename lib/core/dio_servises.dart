import 'package:app/core/sensitive_data.dart';
import 'package:dio/dio.dart';

class DioServises {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://zieeiuozhhjeiseqclvd.supabase.co/rest/v1/",
      headers: {"apiKey": apiKey}));

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
