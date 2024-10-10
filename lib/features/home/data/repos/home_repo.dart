import 'package:kora_news/features/home/data/models/filgoal_news_model.dart';

abstract class HomeRepo{
  Future getMatches({String? url});
  Future getMatchDetails(String url);
  Future<List<FilgoalNewsModel>> getNews({int? index});
  Future getNewsDetails();
}