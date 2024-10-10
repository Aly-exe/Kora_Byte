import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/features/home/data/models/match_details_model.dart';
import 'package:kora_news/features/home/data/models/match_model.dart';
import 'package:kora_news/features/home/data/repos/home_repo_implementation.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_states.dart';

class GetMatchesCubit extends Cubit<GetMatchesStates> {
  GetMatchesCubit() : super(GetMatchesInitialState());
  static GetMatchesCubit get(context) => BlocProvider.of(context);
  HomeRpeoImplementation homeRepoImp = HomeRpeoImplementation();
  List<Matches> matchesList = [];
  late MatchDetails matchDetails=MatchDetails();

  Future getMatches({String? matchday}) async {
    matchesList.clear();
    emit(LoadingGetMatchesState());
    try {
      matchesList = await homeRepoImp.getMatches(url: matchday ?? Constants.yallaKoraMatches);
      emit(SuccessGetMatchesState());
    } catch (e) {
      print(e.toString());
      emit(FailureGetMatchesState(e.toString()));
    }
  }

  Future getMatchDetails(matchUrl) async {
    emit(LoadingMatchDetailsState());
    try {
      matchDetails = await homeRepoImp.getMatchDetails(matchUrl);
      emit(SuccessGetMatchDetailsState());
      
    } catch (error) {
      log("get match error is :${error.toString()}");
      emit(FailureGetMatchDetailsState(
        error.toString(),
      ));
    }
  }
}
