import 'dart:async';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/core/errors/errror_handler.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/details_filgoal_news.dart';
import 'package:kora_news/features/home/data/models/filgoal_news_model.dart';
import 'package:kora_news/features/home/data/models/match_details_model.dart';
import 'package:kora_news/features/home/data/models/match_model.dart';
import 'package:kora_news/services/get_news_states.dart';

class GetNewsBloc extends Cubit<GetNewsStates> {
  GetNewsBloc() : super(GetNewsInitialState());
  static GetNewsBloc get(context) => BlocProvider.of(context);
  late MatchDetails matchinfo = MatchDetails();
  List<FilgoalNewsModel> newsList = [];
  List<Matches> matchesList = [];
  var newsSection;
  var detailesFilgoalNewsModel = DetailesFilgoalNewsModel();
  bool matchesIsLoading = true;
  bool newsIsLoading = true;
  
// Get Matchs Time At Home Screen
  Future getMatches({String? link}) async {
    matchesIsLoading = true;
    var url = Uri.decodeFull(link ?? Constants.yallaKoraMatches);
    emit(LoadingMatchesState());
    await DioHelper.getData(link ?? url).then((value) {
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

      List<String> Egyptionteams = ['مصر', 'الأهلي', 'الزمالك'];
      List<String> seconedTeamsPriority = [
        'ريال مدريد',
        'برشلونة',
        'اتلتيكو مدريد',
        'آرسنال',
        'مانشستر سيتي',
        'ليفربول',
        'تشيلسي',
        'مانشستر يونايتد'
      ];
      List<String> priorityTeams = [
        'أستون فيلا',
        'نيوكاسل',
        'توتنهام',
        'بورنموث',
        'برينتفورد',
        'برايتون'
            'كريستال بالاس',
        'إيفرتون',
        'فولهام',
        'لوتون تاون',
        'نوتينغهام فورست',
        'شيفيلد يونايتد',
        'وست هام',
        'وولفز',
        'النصر',
        'الاتحاد',
        'الهلال',
        'أهلي جدة',
        'الريان',
        'الإسماعيلي',
        'غزل المحله',
        'الاتحاد السكندري',
        'بيراميدز'
      ];
      List<String> highestPriorityStates = [
        'استراحة',
        'الشوط الثاني',
        'الشوط الأول'
      ];
      matchesList.sort((a, b) {
        // Determine priority based on match state
        int aPriority = highestPriorityStates.indexOf(a.matchState);
        int bPriority = highestPriorityStates.indexOf(b.matchState);

        if (aPriority != -1 && bPriority == -1) {
          return -1; // Move a before b if a has higher priority state
        } else if (aPriority == -1 && bPriority != -1) {
          return 1; // Move b before a if b has higher priority state
        }
        // Check if either team is in the priority list
        bool aIsPriorityeg = Egyptionteams.contains(a.homeTeam) ||
            Egyptionteams.contains(a.awayTeam);
        bool bIsPriorityeg = Egyptionteams.contains(b.homeTeam) ||
            Egyptionteams.contains(b.awayTeam);

        if (aIsPriorityeg && !bIsPriorityeg) {
          return -1; // Move a before b if a is a priority team
        } else if (!aIsPriorityeg && bIsPriorityeg) {
          return 1; // Move b before a if b is a priority team
        }
        bool aIsPrioritySpEn = seconedTeamsPriority.contains(a.homeTeam) ||
            seconedTeamsPriority.contains(a.awayTeam);
        bool bIsPrioritySpEn = seconedTeamsPriority.contains(b.homeTeam) ||
            seconedTeamsPriority.contains(b.awayTeam);

        if (aIsPrioritySpEn && !bIsPrioritySpEn) {
          return -1; // Move a before b if a is a priority team
        } else if (!aIsPrioritySpEn && bIsPrioritySpEn) {
          return 1; // Move b before a if b is a priority team
        }

        bool aIsPriority = priorityTeams.contains(a.homeTeam) ||
            priorityTeams.contains(a.awayTeam);
        bool bIsPriority = priorityTeams.contains(b.homeTeam) ||
            priorityTeams.contains(b.awayTeam);

        if (aIsPriority && !bIsPriority) {
          return -1; // Move a before b if a is a priority team
        } else if (!aIsPriority && bIsPriority) {
          return 1; // Move b before a if b is a priority team
        }

        // Parse matchTime strings to DateTime objects for comparison
        DateTime aTime = DateTime.parse("1970-01-01 ${a.matchTime}:00");
        DateTime bTime = DateTime.parse("1970-01-01 ${b.matchTime}:00");

        if (a.matchState == "انتهت" && b.matchState != "انتهت") {
          return 1; // Move a after b if a is "انتهت"
        } else if (a.matchState != "انتهت" && b.matchState == "انتهت") {
          return -1; // Move b after a if b is "انتهت"
        }

        // If all matches have the state "انتهت", sort by team names
        if (a.matchState == "انتهت" && b.matchState == "انتهت") {
          int teamComparison = a.homeTeam.compareTo(b.homeTeam);
          if (teamComparison == 0) {
            teamComparison = a.awayTeam.compareTo(b.awayTeam);
          }
          return teamComparison;
        }

        // Compare by time if neither match state is "انتهت"
        return aTime.compareTo(bTime);
      });
      if (matchesList.isNotEmpty) {
        matchesIsLoading = false;
      }
      emit(SucccesGetMatchesState());
    }).catchError((error) {
      // print(ErrorHandler.fromDioException(error));
      emit(FailedGetMatchesState());
    });
  }

  Future getFilgoalNews() async {
    newsList.clear();
    newsIsLoading = true;
    emit(LoadingFilgoalNewsState());
    await DioHelper.getData(Constants.filGaoal).then((value) {
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
        if (newsList.isNotEmpty) {
          newsIsLoading = false;
        }
        emit(SucccesGetFilgoalNewsState());
      });
    }).catchError((error) {
      emit(FailedGetFilgoalNewsState());
    });
  }
// Get Websites News At Home Screen 
  Future getNews(int index) async {
    newsIsLoading = true;
    emit(LoadingGetNewsState());
    if (index == 0) {
      await getEplNews();
    } else if (index == 1) {
      await getFilGoalAllNews();
    } else if (index == 2) {
      await getYallaKoraNews();
    } else if (index == 3) {
      await getKoraPlusNews();
    } else if (index == 4) {
      await getBtolatNews();
    }
    if (newsList.isNotEmpty) {
      newsIsLoading = false;
    }
  }

  Future getDetailsNews(context, String baseurl, String Url) async {
    detailesFilgoalNewsModel.detailes = "";
    detailesFilgoalNewsModel.imagelink = "";
    detailesFilgoalNewsModel.title = "";
    emit(LoadingDetailsNewsState());
    if (baseurl == "https://filgoal.com") {
      await DioHelper.getData(baseurl + Url).then((value) {
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
      await DioHelper.getData(baseurl + Url).then((value) {
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
      await DioHelper.getData(baseurl + Url).then((value) {
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
        detailesFilgoalNewsModel.title = title;
        detailesFilgoalNewsModel.imagelink = imageUrl;
        detailesFilgoalNewsModel.detailes = description;
        emit(SucccesGetDetailsNewsState());
      }).catchError((error) {
        emit(FailedGetDetailsNewsState());
      });
    } else if (baseurl == "https://koraplus.com") {
      await DioHelper.getData(baseurl + Url).then((value) {
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
      await DioHelper.getData(baseurl + Url).then((value) {
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
    await scrapingMatchDetails(url);
  }

  int currentindex = 1;
  void changeCurrentindex(int index) {
    currentindex = index;
  }

  int sourceCurrentIndex = 1;
  void changeSourceIndex(index) {
    sourceCurrentIndex = index;
    emit(ChangeSourceIndexState());
  }

// Function That Get and Scrap Websites News
  Future getEplNews() async {
    await DioHelper.getData(Constants.Epl).then((value) {
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
  }

  Future getFilGoalAllNews() async {
    await DioHelper.getData(Constants.filGaoal).then((value) {
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
  }

  Future getYallaKoraNews() async {
    await DioHelper.getData(Constants.yallaKora).then((value) {
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
  }

  Future getKoraPlusNews() async {
    await DioHelper.getData(Constants.koraPlus).then((value) {
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
  }

  Future getBtolatNews() async {
    await DioHelper.getData(Constants.btolat).then((value) {
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

// Function responsible about Scrapping YallaKora website To get Matches details
Future scrapingMatchDetails(url)async{
  var encoded = Uri.encodeFull(url);

    await DioHelper.getData(encoded).then((value) {
      
      var dataContainer =
          BeautifulSoup(value.data).find("section", class_: "mtchDtlsRslt");
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
          ?.getText()
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
          ?.getText()
          .toString();
      matchinfo.teamBscore =
          TeamBScoreContainer == null ? "0" : TeamBScoreContainer;
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
              .trim() ??
          "لا توجد قنوات ناقله";
      // Team A Score Players And Goals Times
      var teamAscorePlayersList = dataContainer
          ?.find("div", class_: "team teamA playerScorers")
          ?.findAll("span", class_: "playerName");

      matchinfo.teamAScorePlayers.clear();
      teamAscorePlayersList == null
          ? matchinfo.teamAScorePlayers = []
          : teamAscorePlayersList.forEach((element) {
              matchinfo.teamAScorePlayers.add(element.getText());
            });

      var teamASGoalsTimesList = dataContainer
          ?.find("div", class_: "team teamA playerScorers")
          ?.findAll("div", class_: 'goal icon-goal');

      List<String> teamAPlayers = [];
      List<List<String>> teamAGoalsTime = [];
      teamAPlayers.clear();
      teamAGoalsTime.clear();
      for (var goalDiv in teamASGoalsTimesList!) {
        // Extract the player's name
        var playerName = goalDiv.find('span', class_: 'playerName')?.text ?? '';

        // Extract the times associated with the player
        var times =
            goalDiv.findAll('span', class_: 'time').map((e) => e.text).toList();

        // Check if player is already in the list
        int playerIndex = teamAPlayers.indexOf(playerName);
        if (playerIndex == -1) {
          // New player, add to the list
          teamAPlayers.add(playerName);
          teamAGoalsTime.add(times); // Add the times for this player
        } else {
          // Existing player, append the times
          teamAGoalsTime[playerIndex].addAll(times);
        }
      }
      matchinfo.teamAScoreTimes.clear();
      matchinfo.teamAScoreTimes = teamAGoalsTime;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // Team B Score Players And Goals Times
      var teamBscorePlayersList = dataContainer
          ?.find("div", class_: "team teamB playerScorers")
          ?.findAll("span", class_: "playerName");

      matchinfo.teamBScorePlayers.clear();
      teamBscorePlayersList == null
          ? matchinfo.teamBScorePlayers = []
          : teamBscorePlayersList.forEach((element) {
              matchinfo.teamBScorePlayers.add(element.getText());
            });
      // Team B Goals Time
      var teamBSGoalsTimesList = dataContainer
          ?.find("div", class_: "team teamB playerScorers")
          ?.findAll("div", class_: 'goal icon-goal');

      List<String> teamBPlayers = [];
      List<List<String>> teamBGoalsTime = [];
      teamBPlayers.clear();
      teamBGoalsTime.clear();
      for (var goalDiv in teamBSGoalsTimesList!) {
        // Extract the player's name
        var playerName = goalDiv.find('span', class_: 'playerName')?.text ?? '';

        // Extract the times associated with the player
        var times =
            goalDiv.findAll('span', class_: 'time').map((e) => e.text).toList();

        // Check if player is already in the list
        int playerIndex = teamBPlayers.indexOf(playerName);
        if (playerIndex == -1) {
          // New player, add to the list
          teamBPlayers.add(playerName);
          teamBGoalsTime.add(times); // Add the times for this player
        } else {
          // Existing player, append the times
          teamBGoalsTime[playerIndex].addAll(times);
        }
      }
      matchinfo.teamBScoreTimes.clear();
      matchinfo.teamBScoreTimes = teamBGoalsTime;

      emit(SucccesGetDetailsMatchesState());
    }).catchError((Error) {
      print('Error: $Error');
      emit(FailedGetDetailsMatchesState());
    });
}

}