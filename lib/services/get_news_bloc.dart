import 'dart:async';
import 'dart:developer';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/constants/constants.dart';
import 'package:kora_news/models/details_filgoal_news.dart';
import 'package:kora_news/models/filgoal_news_model.dart';
import 'package:kora_news/models/match_details_model.dart';
import 'package:kora_news/models/match_model.dart';
import 'package:kora_news/services/get_news_states.dart';

class GetNewsBloc extends Cubit<GetNewsStates> {
  GetNewsBloc() : super(GetNewsInitialState());
  static GetNewsBloc get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  late MatchDetails matchinfo = MatchDetails();

  List<FilgoalNewsModel> newsList = [];
  List<Matches> matchesList = [];
  var newsSection;
  var detailesFilgoalNewsModel = DetailesFilgoalNewsModel();
  Future getMatches({String? link}) async {
    var url = Uri.decodeFull(link ?? Constants.yallaKoraMatches);
    emit(LoadingMatchesState());

    await dio.get(link ?? url).then((value) {
      // matchesList.add(Matches(homeTeam: "", awayTeam: "", matchhref: "", homeScore: "", awayScore: "", matchState: "", matchTime: ""));
      matchesList.clear();
      var data =
          BeautifulSoup(value.data).body?.findAll("div", class_: "liItem");
      if (data != null) {
        data.forEach((e) {
          matchesList.add(Matches(
              homeTeam: e.find('div', class_: "teamA")!.find("p")!.text.trim(),
              awayTeam: e.find('div', class_: "teamB")!.find("p")!.text.trim(),
              matchhref:
                  "https://www.yallakora.com${e.find("a")!.attributes['href']!.toString()}",
              homeScore: e
                  .find('div', class_: "MResult")!
                  .findAll("span", class_: "score")[0]
                  .text,
              awayScore: e
                  .find('div', class_: "MResult")!
                  .findAll("span", class_: "score")[1]
                  .text,
              matchState:
                  e.find('div', class_: "matchStatus")!.find("span")!.text,
              matchTime: e
                  .find('div', class_: "MResult")!
                  .find("span", class_: "time")!
                  .text,
              awayTeamimage: e
                  .find('div', class_: "teamB")!
                  .find("img")!
                  .attributes['src']!
                  .toString(),
              homeTeamimage: e
                  .find('div', class_: "teamA")!
                  .find("img")!
                  .attributes['src']!
                  .toString()));
        });
      }

      emit(SucccesGetMatchesState());
    }).catchError((error) {
      emit(FailedGetMatchesState());
    });
  }

  Future getFilgoalNews() async {
    emit(LoadingFilgoalNewsState());
    await dio.get(Constants.filGaoal).then((value) {
      newsSection = BeautifulSoup(value.data)
          .body!
          .find("div", id: "main-news")!
          .findAll("div", class_: "news-block");

      //fill NewsList By data
      newsSection.forEach((e) {
        newsList.add(FilgoalNewsModel(
          baseurl: "https://filgoal.com",
          href: e.find("a")!.attributes['href'],
          title: e.find("h6")!.text.trim(),
          detailes: "There is no details till now",
          imagelink: "https:${e.find("img")!.attributes["data-src"]}",
        ));
        emit(SucccesGetFilgoalNewsState());
      });
    }).catchError((error) {
      emit(FailedGetFilgoalNewsState());
    });
  }

  Future getNews(int index) async {
    emit(LoadingGetNewsState());
    if (index == 0) {
      await dio.get(Constants.Epl).then((value) {
        newsSection = BeautifulSoup(value.data)
            .body!
            .find("div", class_: "flex mt-3 px-4 w-full flex-wrap")!
            .findAll("a");
        newsList.clear();

        //fill NewsList By data
        newsSection.forEach((e) {
          newsList.add(FilgoalNewsModel(
            baseurl: "https://egyptianproleague.com",
            href: e.attributes['href'],
            title: e.find("h3")!.text.trim(),
            detailes: "There is no details till now",
            imagelink: e.find("img")!.attributes["src"],
          ));
          emit(SucccesGetNewsState());
        });
      }).catchError((error) {
        emit(FailedGetNewsState());
      });
    } else if (index == 1) {
      await dio.get(Constants.filGaoal).then((value) {
        newsSection = BeautifulSoup(value.data)
            .find("div", class_: "main_body")!
            .find("div", id: "list-box")!
            .findAll("li");
        newsList.clear();

        //fill NewsList By data
        newsSection.forEach((e) {
          newsList.add(FilgoalNewsModel(
            baseurl: "https://filgoal.com",
            href: e.find("a")!.attributes['href'],
            title: e.find("h6")!.text.trim(),
            detailes: "There is no details till now",
            imagelink: "https:${e.find("img")!.attributes["data-src"]}",
          ));
          emit(SucccesGetNewsState());
        });
      }).catchError((error) {
        emit(FailedGetNewsState());
      });
    } else if (index == 2) {
      await dio.get(Constants.yallaKora).then((value) {
        newsSection = BeautifulSoup(value.data)
            .body!
            .find("ul", id: "ulListing")!
            .findAll("div", class_: "link");
        newsList.clear();

        //fill NewsList By data
        newsSection.forEach((e) {
          newsList.add(FilgoalNewsModel(
            baseurl: "https://yallakora.com",
            href: e.find('a')!.attributes['href'].toString(),
            title: e.find('p')!.text.toString(),
            detailes: "There is no details till now", //e.find("p")!.text,
            imagelink: e.find('img')!.attributes['data-src'].toString(),
          ));
          emit(SucccesGetNewsState());
        });
      }).catchError((error) {
        emit(FailedGetNewsState());
      });
    } else if (index == 3) {
      await dio.get(Constants.koraPlus).then((value) {
        newsSection = BeautifulSoup(value.data)
            .body!
            .find("div", class_: "SearchResultBlock")!
            .findAll("div", class_: "SecondNews");
        newsList.clear();

        //fill NewsList By data
        newsSection.forEach((e) {
          newsList.add(FilgoalNewsModel(
            baseurl: "https://koraplus.com",
            href: e.find('h3')!.find('a')!.attributes['href'],
            title: e.find('h3')!.text.toString().trim(),
            detailes: "There is no details till now",
            imagelink: e
                .find("div", class_: "secondNewsBlockImage")!
                .find('img')!
                .attributes['src'],
          ));
          emit(SucccesGetNewsState());
        });
      }).catchError((error) {
        emit(FailedGetNewsState());
      });
    } else if (index == 4) {
      await dio.get(Constants.btolat).then((value) {
        newsSection = BeautifulSoup(value.data)
            .body!
            .findAll("div", class_: "categoryNewsCard");
        newsList.clear();

        //fill NewsList By data
        newsSection.forEach((e) {
          newsList.add(FilgoalNewsModel(
            baseurl: "https://www.btolat.com",
            href: e.find('a')!.attributes['href'],
            title: e.find('h3')!.text.toString().trim(),
            detailes: "There is no details till now",
            imagelink: e.find('img')!.attributes['data-original'],
          ));
          emit(SucccesGetNewsState());
        });
      }).catchError((error) {
        emit(FailedGetNewsState());
      });
    }
  }

  Future getDetailsNews(context, String baseurl, String Url) async {
    emit(LoadingDetailsNewsState());
    if (baseurl == "https://filgoal.com") {
      await dio.get(baseurl + Url).then((value) {
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
        detailesFilgoalNewsModel.detailes = description;
        detailesFilgoalNewsModel.imagelink = imageUrl;
        detailesFilgoalNewsModel.title = title;
        emit(SucccesGetDetailsNewsState());
      }).catchError((error) {
        emit(FailedGetDetailsNewsState());
      });
    } else if (baseurl == "https://egyptianproleague.com") {
      await dio.get(baseurl + Url).then((value) {
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
        detailesFilgoalNewsModel.title = title;
        detailesFilgoalNewsModel.imagelink = imageUrl;
        detailesFilgoalNewsModel.detailes = description;
        emit(SucccesGetDetailsNewsState());
      }).catchError((error) {
        emit(FailedGetDetailsNewsState());
      });
    } else if (baseurl == "https://yallakora.com") {
      await dio.get(baseurl + Url).then((value) {
        var title = BeautifulSoup(value.data)
            .find("h1", class_: "artclHdline")!
            .text
            .trim();
        var descriptionList = BeautifulSoup(value.data)
            .find("div", class_: "ArticleDetails")!
            .findAll("p");
        var description = "";
        descriptionList.forEach((e) {
          description += " \n ${e.text.replaceAll("&nbsp;", "")}";
        });
        var imageUrl = BeautifulSoup(value.data)
            .find("div", class_: "articleContainer")!
            .find("div", class_: "imageCntnr")!
            .find("img")!
            .attributes['src'];
        detailesFilgoalNewsModel.title = title;
        detailesFilgoalNewsModel.imagelink = imageUrl;
        detailesFilgoalNewsModel.detailes = description;
        emit(SucccesGetDetailsNewsState());
      }).catchError((error) {
        emit(FailedGetDetailsNewsState());
      });
    } else if (baseurl == "https://koraplus.com") {
      await dio.get(baseurl + Url).then((value) {
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
        detailesFilgoalNewsModel.title = title;
        detailesFilgoalNewsModel.imagelink = imageUrl;
        detailesFilgoalNewsModel.detailes = description;
        emit(SucccesGetDetailsNewsState());
      }).catchError((error) {
        emit(FailedGetDetailsNewsState());
      });
    } else if (baseurl == "https://www.btolat.com") {
      await dio.get(baseurl + Url).then((value) {
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
        detailesFilgoalNewsModel.title = title;
        detailesFilgoalNewsModel.imagelink = imageUrl;
        detailesFilgoalNewsModel.detailes = description;
        emit(SucccesGetDetailsNewsState());
      }).catchError((error) {
        emit(FailedGetDetailsNewsState());
      });
    }
  }

  Future getMatchDetails(String url) async {
    emit(LoadingDetailsMatchesState());
    var encoded = Uri.encodeFull(url);
    await dio.get(encoded).then((value) {
      var dataContainer =
          BeautifulSoup(value.data).find("section", class_: "mtchDtlsRslt");
      log(dataContainer.toString());
      matchinfo.championName = dataContainer
              ?.find("div", class_: "tourName")
              ?.find("div", class_: "tourNameBtn")
              ?.find("a")
              ?.text
              .toString() ??
          "Dont Find Champion Name";
      matchinfo.round = dataContainer
              ?.find("div", class_: "tourName")
              ?.find("div", class_: "tourNameBtn")
              ?.find("p")
              ?.text
              .trim()
              .toString() ??
          "Dont Find Round";
      matchinfo.date = dataContainer
              ?.find("div", class_: "tourNameBtn matchDateInfo")
              ?.find("span", class_: "date")
              ?.text
              .toString() ??
          "No Date";
      matchinfo.time = dataContainer
              ?.find("div", class_: "tourNameBtn matchDateInfo")
              ?.find("span", class_: "time")
              ?.text
              .toString() ??
          "No Time";
      matchinfo.teamAname = dataContainer
              ?.find("div", class_: "matchScoreInfo")
              ?.find("div", class_: "team teamA")
              ?.find("p")
              ?.text
              .toString()
              .trim() ??
          "Team A";
      matchinfo.teamAimageLink = dataContainer
              ?.find("div", class_: "matchScoreInfo")
              ?.find("div", class_: "team teamA")
              ?.find("img")
              ?.attributes['src']
              .toString() ??
          "Dont Find A IMage Link";
      matchinfo.matchState = dataContainer
              ?.find("div", class_: "matchResult")
              ?.find("p")
              ?.text
              .toString() ??
          "لم تبدأ";
      String? TeamAScoreContainer = dataContainer
          ?.find("div", class_: "matchResult")
          ?.find("div", class_: "result")
          ?.find("span", class_: "a")
          ?.text
          .toString();
      matchinfo.teamAscore = TeamAScoreContainer?.length == 0
          ? "0"
          : TeamAScoreContainer!.length > 2
              ? "0"
              : TeamAScoreContainer;
      String? TeamBScoreContainer = dataContainer
          ?.find("div", class_: "matchResult")
          ?.find("div", class_: "result")
          ?.find("span", class_: "b")
          .toString();
      matchinfo.teamBscore = TeamBScoreContainer?.length == 0
          ? "0"
          : TeamBScoreContainer!.length > 2
              ? "0"
              : TeamBScoreContainer;
      matchinfo.teamBname = dataContainer
              ?.find("div", class_: "matchScoreInfo")
              ?.find("div", class_: "team teamB")
              ?.find("p")
              ?.text
              .toString()
              .trim() ??
          "Team B";
      matchinfo.teamBimageLink = dataContainer
              ?.find("div", class_: "matchScoreInfo")
              ?.find("div", class_: "team teamB")
              ?.find("img")
              ?.attributes['src']
              ?.toString() ??
          "Dont Find B Image Link";
      matchinfo.tvChannels = dataContainer
              ?.find("div", class_: "matchDetInfo")
              ?.find("span")
              ?.text
              .toString() ??
          "لا توجد قنوات ناقله";

      emit(SucccesGetDetailsMatchesState());
    }).catchError((Error) {
      print('Error: $Error');
      emit(FailedGetDetailsMatchesState());
    });
  }

  int currentindex = 1;
  void changeCurrentindex(int index) {
    currentindex = index;
  }
}
