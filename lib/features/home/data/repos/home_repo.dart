abstract class HomeRepo{
  Future getMatches();
  Future getMatchDetails(String url);
  Future getNews();
  Future getNewsDetails();
}