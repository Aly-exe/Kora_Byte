import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/news_details_model.dart';

Future getEplNewsDetails({
  required NewsDetailsModel newsDetails,
  required String baseUrl,
  required String url
}) async {
var value = await DioHelper.getData(baseUrl + url);
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
        newsDetails.title = title;
        newsDetails.imagelink = imageUrl;
        newsDetails.details = description;
}