import 'dart:developer';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/core/functions/arrange_matches_list.dart';
import 'package:kora_news/core/functions/collect_match_data.dart';
import 'package:kora_news/core/functions/collect_match_details_data.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/match_model.dart';
import 'package:kora_news/features/home/data/repos/home_repo.dart';

class HomeRpeoImplementation implements HomeRepo {
  @override
  Future getMatchDetails(String url) async {
    try{
      Response response = await DioHelper.getData(url);
      return scrapingMatchDetails(response.data);
    }catch(error){
      return Future.error(error);
    }
  }

  @override
  Future getMatches({String? url}) async {
    List<Matches> matchesList = [];
    var matcheslink =Uri.decodeFull(url ?? Constants.yallaKoraMatches);
    try{
    var response = await DioHelper.getData(matcheslink);
      fillMatchesList(response, matchesList);
      arrangeMatchesList(matchesList);
      return matchesList;

    }catch(error){
      print("Get Matches List error : $error");
      return error;
    }
  }

  @override
  Future getNews() {
    // TODO: implement getNews
    throw UnimplementedError();
  }

  @override
  Future getNewsDetails() {
    // TODO: implement getNewsDetails
    throw UnimplementedError();
  }
}
