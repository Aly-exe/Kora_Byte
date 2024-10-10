
  import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/filgoal_news_model.dart';

Future getYallaKoraNews() async {
    List<FilgoalNewsModel> newsList=[];
    try{var value=await DioHelper.getData(Constants.yallaKora);
      var newsSection = BeautifulSoup(value.data)
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
      });
      return newsList;
    }catch(error){
      return Future.error(error);
    }
  }
