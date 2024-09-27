import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();
  static Future initDio() async {
    dio = await Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 20),
        receiveTimeout: Duration(seconds: 20)
      )
    );
  }

  static Future<Response> getData(String url) async {
    return await dio.get(url);
  }
}
