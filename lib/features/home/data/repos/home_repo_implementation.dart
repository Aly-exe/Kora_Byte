import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/core/functions/arrange_matches_list.dart';
import 'package:kora_news/core/functions/collect_match_data.dart';
import 'package:kora_news/core/functions/collect_match_details_data.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/data/models/match_model.dart';
import 'package:kora_news/features/home/data/repos/home_repo.dart';

class HomeRpeoImplementation implements HomeRepo {
  @override
  Future getMatchDetails(String url) async {
    var encoded = Uri.encodeFull(url);
    await DioHelper.getData(encoded).then((value) {
      scrapingMatchDetails(value);
    }).catchError((error){
      print("Get Match Details error : $error");
    });
  }

  @override
  Future getMatches({String? matchDayLink}) async {
    List<Matches> matchesList = [];
    var matcheslink =
        Uri.decodeFull(matchDayLink ?? Constants.yallaKoraMatches);
    await DioHelper.getData(matcheslink).then((value) {
      fillMatchesList(value, matchesList);
      arrangeMatchesList(matchesList);
      print(matchesList[0]);
    }).catchError((error) {
      print("Get Matches List error : $error");
    });
  }

  @override
  Future getNews() {
    // TODO: implement getNews
    throw UnimplementedError();
  }

  @override
  Future getNewsDetails() {
    // TODO: implement getNewsDetails
    throw UnimplementedError();
  }
}
