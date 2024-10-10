import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kora_news/features/home/data/models/match_details_model.dart';

MatchDetails scrapingMatchDetails(value) {
  late MatchDetails matchinfo = MatchDetails();

  var dataContainer =
      BeautifulSoup(value).find("section", class_: "mtchDtlsRslt");
  matchinfo.championName = dataContainer
          ?.find("div", class_: "tourName")
          ?.find("div", class_: "tourNameBtn")
          ?.find("a")
          ?.text
          .toString() ??
      "Dont Find Champion Name";
  matchinfo.round = dataContainer
          ?.find("div", class_: "tourName")
          ?.find("div", class_: "tourNameBtn")
          ?.find("p")
          ?.text
          .trim()
          .toString() ??
      "Dont Find Round";
  matchinfo.date = dataContainer
          ?.find("div", class_: "tourNameBtn matchDateInfo")
          ?.find("span", class_: "date")
          ?.text
          .toString() ??
      "No Date";
  matchinfo.time = dataContainer
          ?.find("div", class_: "tourNameBtn matchDateInfo")
          ?.find("span", class_: "time")
          ?.text
          .toString() ??
      "No Time";
  matchinfo.teamAname = dataContainer
          ?.find("div", class_: "matchScoreInfo")
          ?.find("div", class_: "team teamA")
          ?.find("p")
          ?.text
          .toString()
          .trim() ??
      "Team A";
  matchinfo.teamAimageLink = dataContainer
          ?.find("div", class_: "matchScoreInfo")
          ?.find("div", class_: "team teamA")
          ?.find("img")
          ?.attributes['src']
          .toString() ??
      "Dont Find A IMage Link";
  matchinfo.matchState = dataContainer
          ?.find("div", class_: "matchResult")
          ?.find("p")
          ?.text
          .toString() ??
      "لم تبدأ";

  String? TeamAScoreContainer = dataContainer
      ?.find("div", class_: "matchResult")
      ?.find("div", class_: "result")
      ?.find("span", class_: "a")
      ?.getText()
      .toString();
  matchinfo.teamAscore = TeamAScoreContainer?.length == 0
      ? "0"
      : TeamAScoreContainer!.length > 2
          ? "0"
          : TeamAScoreContainer;

  String? TeamBScoreContainer = dataContainer
      ?.find("div", class_: "matchResult")
      ?.find("div", class_: "result")
      ?.find("span", class_: "b")
      ?.getText()
      .toString();
  matchinfo.teamBscore =
      TeamBScoreContainer == null ? "0" : TeamBScoreContainer;
  matchinfo.teamBname = dataContainer
          ?.find("div", class_: "matchScoreInfo")
          ?.find("div", class_: "team teamB")
          ?.find("p")
          ?.text
          .toString()
          .trim() ??
      "Team B";

  matchinfo.teamBimageLink = dataContainer
          ?.find("div", class_: "matchScoreInfo")
          ?.find("div", class_: "team teamB")
          ?.find("img")
          ?.attributes['src']
          ?.toString() ??
      "Dont Find B Image Link";
  matchinfo.tvChannels = dataContainer
          ?.find("div", class_: "matchDetInfo")
          ?.find("span")
          ?.text
          .trim() ??
      "لا توجد قنوات ناقله";
  // Team A Score Players And Goals Times
  var teamAscorePlayersList = dataContainer
      ?.find("div", class_: "team teamA playerScorers")
      ?.findAll("span", class_: "playerName");

  matchinfo.teamAScorePlayers.clear();
  teamAscorePlayersList == null
      ? matchinfo.teamAScorePlayers = []
      : teamAscorePlayersList.forEach((element) {
          matchinfo.teamAScorePlayers.add(element.getText());
        });

  var teamASGoalsTimesList = dataContainer
      ?.find("div", class_: "team teamA playerScorers")
      ?.findAll("div", class_: 'goal icon-goal');

  List<String> teamAPlayers = [];
  List<List<String>> teamAGoalsTime = [];
  teamAPlayers.clear();
  teamAGoalsTime.clear();
  if (teamASGoalsTimesList != null) {
    for (var goalDiv in teamASGoalsTimesList) {
      // Extract the player's name
      var playerName = goalDiv.find('span', class_: 'playerName')?.text ?? '';

      // Extract the times associated with the player
      var times =
          goalDiv.findAll('span', class_: 'time').map((e) => e.text).toList();

      // Check if player is already in the list
      int playerIndex = teamAPlayers.indexOf(playerName);
      if (playerIndex == -1) {
        // New player, add to the list
        teamAPlayers.add(playerName);
        teamAGoalsTime.add(times); // Add the times for this player
      } else {
        // Existing player, append the times
        teamAGoalsTime[playerIndex].addAll(times);
      }
    }
  }

  matchinfo.teamAScoreTimes.clear();
  matchinfo.teamAScoreTimes = teamAGoalsTime;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Team B Score Players And Goals Times
  var teamBscorePlayersList = dataContainer
      ?.find("div", class_: "team teamB playerScorers")
      ?.findAll("span", class_: "playerName");

  matchinfo.teamBScorePlayers.clear();
  teamBscorePlayersList == null
      ? matchinfo.teamBScorePlayers = []
      : teamBscorePlayersList.forEach((element) {
          matchinfo.teamBScorePlayers.add(element.getText());
        });
  // Team B Goals Time
  var teamBSGoalsTimesList = dataContainer
      ?.find("div", class_: "team teamB playerScorers")
      ?.findAll("div", class_: 'goal icon-goal');

  List<String> teamBPlayers = [];
  List<List<String>> teamBGoalsTime = [];
  teamBPlayers.clear();
  teamBGoalsTime.clear();
  if (teamBSGoalsTimesList != null) {
    for (var goalDiv in teamBSGoalsTimesList) {
      // Extract the player's name
      var playerName = goalDiv.find('span', class_: 'playerName')?.text ?? '';

      // Extract the times associated with the player
      var times =
          goalDiv.findAll('span', class_: 'time').map((e) => e.text).toList();

      // Check if player is already in the list
      int playerIndex = teamBPlayers.indexOf(playerName);
      if (playerIndex == -1) {
        // New player, add to the list
        teamBPlayers.add(playerName);
        teamBGoalsTime.add(times); // Add the times for this player
      } else {
        // Existing player, append the times
        teamBGoalsTime[playerIndex].addAll(times);
      }
    }
  }
  matchinfo.teamBScoreTimes.clear();
  matchinfo.teamBScoreTimes = teamBGoalsTime;
  return matchinfo;
}
