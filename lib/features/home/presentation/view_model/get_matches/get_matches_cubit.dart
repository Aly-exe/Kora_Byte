import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/features/home/data/models/match_model.dart';
import 'package:kora_news/features/home/data/repos/home_repo_implementation.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit_states.dart';

class GetMatchesCubit extends Cubit<GetMatchesStates>{
  GetMatchesCubit():super(GetMatchesInitialState());
  static GetMatchesCubit get(context) => BlocProvider.of(context);
  HomeRpeoImplementation homeRepoImp=HomeRpeoImplementation();
  List<Matches>matchesList=[];
  //Get Matches Method 
  Future getMatches({String? matchday})async{
    matchesList.clear();
    emit(LoadingGetMatchesState());
    try{
      matchesList = await homeRepoImp.getMatches(matchDayLink: matchday);
      
        
          emit(SuccessGetMatchesState());
        
    }catch (e){
      print(e.toString());
      emit(FailureGetMatchesState(e.toString()));
    }
  }

  
}