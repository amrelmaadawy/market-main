import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    var r1 = await dio.get("https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg");
    print("fakestore OK: \${r1.statusCode}");
  } catch(e) {
    print("fakestore FAIL: $e");
  }
  
  try {
    var r2 = await dio.get("https://picsum.photos/200");
    print("picsum OK: \${r2.statusCode}");
  } catch(e) {
    print("picsum FAIL: $e");
  }

  try {
    var r3 = await dio.get("http://via.placeholder.com/150");
    print("placeholder OK: \${r3.statusCode}");
  } catch(e) {
    print("placeholder FAIL: $e");
  }
}
