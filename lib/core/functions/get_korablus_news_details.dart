import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/news_details_model.dart';

Future getKoraBlusNewsDetails({
  required NewsDetailsModel newsDetails,
  required String baseUrl,
  required String url,
})async{
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
}