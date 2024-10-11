import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/news_model.dart';

Future getKoraPlusNews() async {
  List<NewsModel> newsList=[];
    try{var value=await DioHelper.getData(Constants.koraPlus);
      var newsSection = BeautifulSoup(value.data)
          .body!
          .find("div", class_: "SearchResultBlock")!
          .findAll("div", class_: "SecondNews");
      newsList.clear();

      //fill NewsList By data
      newsSection.forEach((e) {
        newsList.add(NewsModel(
          baseurl: "https://koraplus.com",
          href: e.find('h3')!.find('a')!.attributes['href'],
          title: e.find('h3')!.text.toString().trim(),
          detailes: "There is no details till now",
          imagelink: e
              .find("div", class_: "secondNewsBlockImage")!
              .find('img')!
              .attributes['src'],
        ));
      });
      return newsList;
    }catch(error){
      return Future.error(error);
    }
  }

