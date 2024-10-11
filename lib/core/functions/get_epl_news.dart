import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/news_model.dart';

Future getEplNews() async {
    try{
      var value=await DioHelper.getData(Constants.Epl);
      List<NewsModel> newsList=[];
      var newsSection = BeautifulSoup(value.data)
          .body!
          .find("div", class_: "flex mt-3 px-4 w-full flex-wrap")!
          .findAll("a");
      newsList.clear();

      //fill NewsList By data
      newsSection.forEach((e) {
        newsList.add(NewsModel(
          baseurl: "https://egyptianproleague.com",
          href: e.attributes['href'],
          title: e.find("h3")!.text.trim(),
          detailes: "There is no details till now",
          imagelink: e.find("img")!.attributes["src"],
        ));
      });
        return newsList;
    }catch(error){
      return Future.error(error);
    }
  }