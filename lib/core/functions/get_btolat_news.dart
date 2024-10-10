import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/filgoal_news_model.dart';

Future getBtolatNews() async {
  List<FilgoalNewsModel> newsList=[];
  try{
      var value=await DioHelper.getData(Constants.btolat);
      var newsSection = BeautifulSoup(value.data)
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
      });
      return newsList;
  }catch(error){
    return Future.error(error);
  }
  }
