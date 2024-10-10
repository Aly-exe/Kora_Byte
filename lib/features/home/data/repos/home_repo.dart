abstract class HomeRepo{
  Future getMatches({String? url});
  Future getMatchDetails(String url);
  Future getNews();
  Future getNewsDetails();
}