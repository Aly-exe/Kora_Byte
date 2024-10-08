import 'package:intl/intl.dart';

class Constants {
  static final String filGaoal = "https://www.filgoal.com/articles";
  static final String Epl = "https://egyptianproleague.com/news";
  static final String yallaKorabBaseUrl = "https://www.yallakora.com/";
  static final String yallaKora =
      "https://www.yallakora.com/newslisting/%d8%a7%d9%84%d8%a3%d8%ae%d8%a8%d8%a7%d8%b1#nav-menu";
  static final String koraPlus = "https://koraplus.com/section/index";
  DateTime now = DateTime.now();
  static String formatedDateNow =
      DateFormat('MM/dd/yyyy').format(DateTime.now());
  static String formatedDateYesterday = DateFormat('MM/dd/yyyy')
      .format(DateTime.now().subtract(Duration(days: 1)));
  static String formatedDateNextday =
      DateFormat('MM/dd/yyyy').format(DateTime.now().add(Duration(days: 1)));
  static final String yallaKoraMatches =
      "https://www.yallakora.com/match-center/%D9%85%D8%B1%D9%83%D8%B2-%D8%A7%D9%84%D9%85%D8%A8%D8%A7%D8%B1%D9%8A%D8%A7%D8%AA?date=$formatedDateNow";
  static final String yallaKoraMatchesYesterday =
      "https://www.yallakora.com/match-center/%D9%85%D8%B1%D9%83%D8%B2-%D8%A7%D9%84%D9%85%D8%A8%D8%A7%D8%B1%D9%8A%D8%A7%D8%AA?date=$formatedDateYesterday";
  static final String yallaKoraMatchesNextDay =
      "https://www.yallakora.com/match-center/%D9%85%D8%B1%D9%83%D8%B2-%D8%A7%D9%84%D9%85%D8%A8%D8%A7%D8%B1%D9%8A%D8%A7%D8%AA?date=$formatedDateNextday";
  static final String btolat = "https://www.btolat.com/news";
}
