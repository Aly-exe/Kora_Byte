import 'package:kora_news/features/home/data/models/news_model.dart';

abstract class HomeRepo{
  Future getMatches({String? url});
  Future getMatchDetails(String url);
  Future<List<NewsModel>> getNews({int? index});
  Future getNewsDetails({required String baseUrl , required String url});
  void changeSourceIndex(int index);
}