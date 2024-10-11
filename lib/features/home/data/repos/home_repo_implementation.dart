import 'dart:developer';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/core/functions/arrange_matches_list.dart';
import 'package:kora_news/core/functions/collect_match_data.dart';
import 'package:kora_news/core/functions/collect_match_details_data.dart';
import 'package:kora_news/core/functions/get_btolat_news.dart';
import 'package:kora_news/core/functions/get_btolat_news_details.dart';
import 'package:kora_news/core/functions/get_epl_news.dart';
import 'package:kora_news/core/functions/get_epl_news_details.dart';
import 'package:kora_news/core/functions/get_filgoal_news.dart';
import 'package:kora_news/core/functions/get_filgoal_news_details.dart';
import 'package:kora_news/core/functions/get_korablus_news.dart';
import 'package:kora_news/core/functions/get_korablus_news_details.dart';
import 'package:kora_news/core/functions/get_yallakora_news.dart';
import 'package:kora_news/core/functions/get_yallkora_news_details.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/news_details_model.dart';
import 'package:kora_news/features/home/data/models/news_model.dart';
import 'package:kora_news/features/home/data/models/match_model.dart';
import 'package:kora_news/features/home/data/repos/home_repo.dart';

class HomeRpeoImplementation implements HomeRepo {
  @override
  Future getMatchDetails(String url) async {
    try {
      Response response = await DioHelper.getData(url);
      return scrapingMatchDetails(response.data);
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future getMatches({String? url}) async {
    List<Matches> matchesList = [];
    var matcheslink = Uri.decodeFull(url ?? Constants.yallaKoraMatches);
    try {
      var response = await DioHelper.getData(matcheslink);
      fillMatchesList(response, matchesList);
      matchesList = arrangeMatchesList(matchesList);
      return matchesList;
    } catch (error) {
      print("Get Matches List error : $error");
      return Future.error(error);
    }
  }

  @override
  Future<List<NewsModel>> getNews({int? index}) async {
    List<NewsModel> newsList = [];
    try {
      if (index == 0) {
        newsList = await getEplNews();
      } else if (index == 2) {
        newsList = await getYallaKoraNews();
      } else if (index == 3) {
        newsList = await getKoraPlusNews();
      } else if (index == 4) {
        newsList = await getBtolatNews();
      } else {
        newsList = await getFilGoalNews();
      }
      return newsList;
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future getNewsDetails({required String baseUrl, required String url}) async {
    NewsDetailsModel newsDetails = NewsDetailsModel();

    try {
      if (baseUrl == "https://filgoal.com") {
        await getFilGoalNewsDetails(
            url: url, newsDetails: newsDetails, baseUrl: baseUrl);
      } else if (baseUrl == "https://egyptianproleague.com") {
        await getEplNewsDetails(
            baseUrl: baseUrl, url: url, newsDetails: newsDetails);
      } else if (baseUrl == "https://yallakora.com") {
        await getYallaKoraNewsDetails(
            newsDetails: newsDetails, baseUrl: baseUrl, url: url);
      } else if (baseUrl == "https://koraplus.com") {
        await getKoraBlusNewsDetails(
            newsDetails: newsDetails, baseUrl: baseUrl, url: url);
      } else if (baseUrl == "https://www.btolat.com") {
        await getBtolatNewsDetails(
            newsDetails: newsDetails, baseUrl: baseUrl, url: url);
      }
      return newsDetails;
    } catch (error) {
      return Future.error(error);
    }
  }

  int currentSourceindex = 1;
  @override
  int changeSourceIndex(int index) {
    currentSourceindex = index;
    return currentSourceindex;
  }
}
