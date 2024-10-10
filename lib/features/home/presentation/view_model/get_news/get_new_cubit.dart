import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/features/home/data/models/filgoal_news_model.dart';
import 'package:kora_news/features/home/data/repos/home_repo_implementation.dart';
import 'package:kora_news/features/home/presentation/view_model/get_news/get_news_states.dart';

class GetNewsCubit extends Cubit<GetNewsStates>{
  GetNewsCubit() : super(InitialGetNewsState());
  static GetNewsCubit get(context) => BlocProvider.of(context);
  HomeRpeoImplementation homeRepo = HomeRpeoImplementation();
  List<FilgoalNewsModel> newsList=[];
  Future getNews({int?index})async{
    emit(LoadingGetNewsState());
    try{
      newsList=await homeRepo.getNews(index: index);
      log(newsList[0].title??"No Title Get");
      emit(SuccessGetNewsState());
    }catch(error){
      log(error.toString());
      emit(FailedGetNewsState());
    }
  }
}