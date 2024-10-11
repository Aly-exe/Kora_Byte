
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/features/home/data/models/news_details_model.dart';
import 'package:kora_news/features/home/data/models/news_model.dart';
import 'package:kora_news/features/home/data/models/match_details_model.dart';
import 'package:kora_news/features/home/data/models/match_model.dart';

class GetNewsBloc {
  static GetNewsBloc get(context) => BlocProvider.of(context);
  late MatchDetails matchinfo = MatchDetails();
  List<NewsModel> newsList = [];
  List<Matches> matchesList = [];
  var newsSection;
  var detailesFilgoalNewsModel = NewsDetailsModel();
  bool matchesIsLoading = true;
  bool newsIsLoading = true;
  
// Get Matchs Time At Home Screen
  
  int currentindex = 1;
  void changeCurrentindex(int index) {
    currentindex = index;
  }

  int sourceCurrentIndex = 1;
  void changeSourceIndex(index) {
    sourceCurrentIndex = index;
    // emit(ChangeSourceIndexState());
  }

}