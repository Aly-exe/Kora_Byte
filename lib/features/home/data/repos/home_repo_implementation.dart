import 'dart:developer';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/core/functions/arrange_matches_list.dart';
import 'package:kora_news/core/functions/collect_match_data.dart';
import 'package:kora_news/core/functions/collect_match_details_data.dart';
import 'package:kora_news/core/functions/get_btolat_news.dart';
import 'package:kora_news/core/functions/get_epl_news.dart';
import 'package:kora_news/core/functions/get_filgoal_news.dart';
import 'package:kora_news/core/functions/get_korablus_news.dart';
import 'package:kora_news/core/functions/get_yallakora_news.dart';
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
        var value = await DioHelper.getData(baseUrl+url);
        var title = BeautifulSoup(value.data)
            .find("div", class_: "title")!
            .find("h1")!
            .text
            .trim();
        var descriptionList = BeautifulSoup(value.data)
            .find("div", id: "details_content")!
            .findAll("p");
        var description = "";
        descriptionList.forEach((e) {
          description += "\n ${e.text}";
        });
        var imageUrl =
            "https:${BeautifulSoup(value.data).find("div", class_: "details")!.find("img")!.attributes['src']}";
        newsDetails.details = description;
        newsDetails.imagelink = imageUrl;
        newsDetails.title = title;
        log(newsDetails.details!);
        log(newsDetails.imagelink!);
        log(newsDetails.title!);
      } else if (baseUrl == "https://egyptianproleague.com") {
        var value = await DioHelper.getData(baseUrl + url);
        var title = BeautifulSoup(value.data)
            .find("h1",
                class_:
                    "line-height-3 text-base font-medium md:text-2xl md:col-8")!
            .text
            .trim();
        var descriptionList = BeautifulSoup(value.data)
            .find("div", class_: "news-details-container px-4")!
            .findAll("p");
        var description = "";
        descriptionList.forEach((e) {
          description += " \n ${e.text}";
        });
        var imageUrl = BeautifulSoup(value.data)
            .find("img", class_: "w-full")!
            .attributes['src'];
        newsDetails.title = title;
        newsDetails.imagelink = imageUrl;
        newsDetails.details = description;
      } else if (baseUrl == "https://yallakora.com") {
        var value = await DioHelper.getData(baseUrl + url);
        String title = BeautifulSoup(value.data)
                .find("h1", class_: "artclHdline")
                ?.text
                .trim() ??
            BeautifulSoup(value.data).body!.title!.text;
        var descriptionList = BeautifulSoup(value.data)
            .find("div", class_: "ArticleDetails")!
            .findAll("p");
        var description = "";
        descriptionList.forEach((e) {
          description += " \n ${e.text.replaceAll("&nbsp;", "")}";
        });
        if (description == "") {
          description = BeautifulSoup(value.data)
              .find("div", class_: "ArticleDetails details")!
              .find("p")!
              .text;
        }
        var imageUrl = BeautifulSoup(value.data)
            .find("div", class_: "articleContainer")!
            .find("div", class_: "imageCntnr")!
            .find("img")!
            .attributes['src'];
        newsDetails.title = title;
        newsDetails.imagelink = imageUrl;
        newsDetails.details = description;
      } else if (baseUrl == "https://koraplus.com") {
        var value = await DioHelper.getData(baseUrl + url);
        var title = BeautifulSoup(value.data)
            .find("div", class_: "articleMainTitle")!
            .find("h1")!
            .text
            .trim();
        var descriptionList = BeautifulSoup(value.data)
            .find("div", class_: "ArticleContent")!
            .findAll("p");
        var description = "";
        descriptionList.forEach((e) {
          description += "\n ${e.text}";
        });
        var imageUrl = BeautifulSoup(value.data)
            .find("div", class_: "detailsMainImage")!
            .find("img")!
            .attributes['src'];
        newsDetails.title = title;
        newsDetails.imagelink = imageUrl;
        newsDetails.details = description;
      } else if (baseUrl == "https://www.btolat.com") {
        var value = await DioHelper.getData(baseUrl + url);
        var title = BeautifulSoup(value.data)
            .find("article", class_: "post")!
            .find("h1", class_: "title")!
            .text
            .trim();
        var descriptionList = BeautifulSoup(value.data)
            .find("div", class_: "article-body")!
            .findAll("p");
        var style = '''#aniBox {
        margin: 0px;
    }

        #aniBox div, #gpt-passback, #gpt-passback div, .aries_stage, .article-body div {
            margin-bottom: 0px;
        }''';
        var script = '''var s, r = false;
    s = document.createElement('script');
    s.src = "https://cdn.ideanetwork.site/js/AdScript/Btolat/Init.js?" + new Date().toJSON().slice(0, 13);
    document.getElementsByTagName('body')[0].appendChild(s);''';

        var description = "";
        descriptionList.forEach((e) {
          description +=
              "${e.getText().replaceAll(style, '').replaceAll(script, '')}";
        });
        var imageUrl = BeautifulSoup(value.data)
            .find("div", class_: "image-box")!
            .find("img")!
            .attributes['src'];
        newsDetails.title = title;
        newsDetails.imagelink = imageUrl;
        newsDetails.details = description;
      }
      return newsDetails;
    } catch (error) {
      return Future.error(error);
    }
  }
}
