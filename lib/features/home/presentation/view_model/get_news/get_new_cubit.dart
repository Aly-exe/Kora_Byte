import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/features/home/data/models/news_details_model.dart';
import 'package:kora_news/features/home/data/models/news_model.dart';
import 'package:kora_news/features/home/data/repos/home_repo_implementation.dart';
import 'package:kora_news/features/home/presentation/view_model/get_news/get_news_states.dart';

class GetNewsCubit extends Cubit<GetNewsStates>{
  GetNewsCubit() : super(InitialGetNewsState());
  static GetNewsCubit get(context) => BlocProvider.of(context);
  HomeRpeoImplementation homeRepo = HomeRpeoImplementation();
  List<NewsModel> newsList=[];
  NewsDetailsModel newsDetails=NewsDetailsModel();
  Future getNews({int?index})async{
    emit(LoadingGetNewsState());
    try{
      newsList=await homeRepo.getNews(index: index);
      emit(SuccessGetNewsState());
    }catch(error){
      log(error.toString());
      emit(FailedGetNewsState());
    }
  }
  Future getNewsDetails({required String baseUrl ,required String url})async{
    emit(LoadingGetNewsDetailsState());
    try{
      newsDetails=await homeRepo.getNewsDetails(baseUrl: baseUrl, url:url);
      emit(SuccessGetNewsDetailsState());
    }catch(error){
      log("Cubit Error $error");
      emit(FailedGetNewsDetailsState());
    }
  }
}