import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';
import 'package:kora_news/features/home/data/models/match_model.dart';

void fillMatchesList(Response value , List matchesList){
  var data =BeautifulSoup(value.data).body?.findAll("div", class_: "liItem");
      if (data != null) {
        data.forEach((e) {
          matchesList.add(Matches(
              homeTeam: e.find('div', class_: "teamA")!.find("p")!.text.trim(),
              awayTeam: e.find('div', class_: "teamB")!.find("p")!.text.trim(),
              matchhref:
                  "https://www.yallakora.com${e.find("a")!.attributes['href']!.toString()}",
              homeScore: e
                  .find('div', class_: "MResult")!
                  .findAll("span", class_: "score")[0]
                  .text,
              awayScore: e
                  .find('div', class_: "MResult")!
                  .findAll("span", class_: "score")[1]
                  .text,
              matchState:
                  e.find('div', class_: "matchStatus")!.find("span")!.text,
              matchTime: e
                  .find('div', class_: "MResult")!
                  .find("span", class_: "time")!
                  .text,
              awayTeamimage: e
                  .find('div', class_: "teamB")!
                  .find("img")!
                  .attributes['src']!
                  .toString(),
              homeTeamimage: e
                  .find('div', class_: "teamA")!
                  .find("img")!
                  .attributes['src']!
                  .toString()));
        });
      }
}
