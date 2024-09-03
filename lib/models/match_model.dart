class Matches {
  final String homeTeam;
  final String awayTeam;
  final String matchState;
  final String matchTime;
  final String homeScore;
  final String awayScore;
  final String leagueName;

  Matches(
      {required this.homeTeam,
      required this.awayTeam,
      required this.homeScore,
      required this.awayScore,
      required this.matchState,
      required this.matchTime,
      required this.leagueName});
}
