import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/news_details_model.dart';

Future getBtolatNewsDetails({
  required NewsDetailsModel newsDetails,
  required String baseUrl,
  required String url,
})async{
  var value = await DioHelper.getData(baseUrl + url);
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
        newsDetails.title = title;
        newsDetails.imagelink = imageUrl;
        newsDetails.details = description;
  }