import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/news_model.dart';

Future getFilGoalNews() async {
  List<NewsModel> newsList=[];
    try{var value=await DioHelper.getData(Constants.filGaoal);
      var newsSection = BeautifulSoup(value.data)
          .find("div", class_: "main_body")!
          .find("div", id: "list-box")!
          .findAll("li");
      newsList.clear();

      //fill NewsList By data
      newsSection.forEach((e) {
        newsList.add(NewsModel(
          baseurl: "https://filgoal.com",
          href: e.find("a")!.attributes['href'],
          title: e.find("h6")!.text.trim(),
          detailes: "There is no details till now",
          imagelink: "https:${e.find("img")!.attributes["data-src"]}",
        ));
      });return newsList;
    }catch(error){
      return Future.error(error);
    }
  }