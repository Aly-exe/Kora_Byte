import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/news_details_model.dart';

Future getYallaKoraNewsDetails({
  required NewsDetailsModel newsDetails,
  required String baseUrl,
  required String url,
})async{
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
}