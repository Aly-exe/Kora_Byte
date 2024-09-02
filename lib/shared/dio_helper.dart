import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio() ;
  static Future initDio() async {
    dio = await Dio(

    );
  }

  static Future getData(String url)async{
    await dio.get(url);
  }
}