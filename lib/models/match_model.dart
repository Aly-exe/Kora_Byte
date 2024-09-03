class Matches {
  String homeTeam;
  String awayTeam;
  String matchhref;
  String? homeTeamimage;
  String? awayTeamimage;
  String matchState;
  String matchTime;
  String homeScore;
  String awayScore;

  Matches(
      {required this.homeTeam,
      required this.awayTeam,
      required this.matchhref,
      this.homeTeamimage,
      this.awayTeamimage,
      required this.homeScore,
      required this.awayScore,
      required this.matchState,
      required this.matchTime});
}
