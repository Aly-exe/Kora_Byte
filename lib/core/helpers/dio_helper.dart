import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();
  static Future initDio() async {
    dio = await Dio();
  }

  static Future<Response> getData(String url) async {
    return await dio.get(url);
  }
}
