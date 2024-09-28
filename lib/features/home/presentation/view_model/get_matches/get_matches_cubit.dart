import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit_states.dart';

class GetMatchesCubit extends Cubit<GetMatchesStates>{
  GetMatchesCubit():super(GetMatchesInitialState());

  
}