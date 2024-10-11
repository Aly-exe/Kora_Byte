import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/news_details_model.dart';

Future getFilGoalNewsDetails({
  required NewsDetailsModel newsDetails,
  required String baseUrl,
  required String url,
})async{
  var value = await DioHelper.getData(baseUrl + url);
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
}