import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/core/constants/colors.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/features/home/data/models/match_model.dart';
import 'package:kora_news/features/home/data/repos/home_repo.dart';
import 'package:kora_news/features/home/data/repos/home_repo_implementation.dart';
import 'package:kora_news/features/home/presentation/view/widgets/matches_widget.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit_states.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';
import 'package:kora_news/core/widgets/custom_appbar.dart';
import 'package:kora_news/core/widgets/custom_dialog.dart';
import 'package:kora_news/features/home/presentation/view/widgets/matches_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/news_list_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/sources_lisview_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMatchesCubit(),
      child: BlocBuilder<GetMatchesCubit, GetMatchesStates>(
        builder: (context, state) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(onPressed: () async {
                await GetMatchesCubit.get(context).getMatches(matchday: Constants.yallaKoraMatchesNextDay);
                log(GetMatchesCubit.get(context).matchesList[0].awayTeam);
              }),
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(60), child: KoraByteAppBar()),
              // <<<<<<<<<<<<<<< Body >>>>>>>>>>>>
              body: RefreshIndicator(
                color: ColorPallet.kNavyColor,
                onRefresh: () async {
                },
                child: Stack(
                  children: [
                    CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          // Matches Widget
                            
                          SliverToBoxAdapter(
                            child: MatchesWidget(),
                          ),
                            
                          // Sources Widget
                            
                          // SliverToBoxAdapter(
                          //   child: SourcesListViewWidget(),
                          // ),
                            
                          // News Widget
                            
                          // NewsList()
                        ]),
                    // if (state is LoadingDetailsNewsState ||
                    //     state is LoadingDetailsMatchesState)
                    //   CustomLoadingDialog()
                  ],
                ),
              ),
              // body: BlocBuilder<GetNewsBloc, GetNewsStates>(
              //   builder: (context, state) {
              //     return RefreshIndicator(
              //       color: ColorPallet.kNavyColor,
              //       onRefresh: () async {
              //         await GetNewsBloc.get(context).getMatches();
              //         await GetNewsBloc.get(context)
              //             .getNews(GetNewsBloc.get(context).sourceCurrentIndex);
              //       },
              //       child: Stack(
              //         children: [
              //           CustomScrollView(
              //               physics: BouncingScrollPhysics(),
              //               slivers: [
              //                 // Matches Widget

              //                 SliverToBoxAdapter(
              //                   child: MatchesWidget(),
              //                 ),

              //                 // Sources Widget

              //                 SliverToBoxAdapter(
              //                   child: SourcesListViewWidget(),
              //                 ),

              //                 // News Widget

              //                 NewsList()
              //               ]),
              //           if (state is LoadingDetailsNewsState ||
              //               state is LoadingDetailsMatchesState)
              //             CustomLoadingDialog()
              //         ],
              //       ),
              //     );
              //   },
              // )
              );
        
        },
      ),
    );
  }
}
