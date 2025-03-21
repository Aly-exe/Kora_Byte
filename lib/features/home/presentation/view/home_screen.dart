import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/core/constants/colors.dart';
import 'package:kora_news/core/widgets/custom_appbar.dart';
import 'package:kora_news/core/widgets/custom_dialog.dart';
import 'package:kora_news/features/home/presentation/view/widgets/matches_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/news_list_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/sources_lisview_widget.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_states.dart';
import 'package:kora_news/features/home/presentation/view_model/get_news/get_new_cubit.dart';
import 'package:kora_news/features/home/presentation/view_model/get_news/get_news_states.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetMatchesCubit()..getMatches()),
        BlocProvider(create: (context) => GetNewsCubit()..getNews()),
      ],
      child: BlocBuilder<GetMatchesCubit, GetMatchesStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(60), child: KoraByteAppBar()),
            // <<<<<<<<<<<<<<< Body >>>>>>>>>>>>
            body: RefreshIndicator(
              color: ColorPallet.kNavyColor,
              onRefresh: () async {
                await Future.wait([
                  GetMatchesCubit.get(context).getMatches(),
                  GetNewsCubit.get(context).getNews()
                ]);
              },
              child: Stack(
                children: [
                  CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
                    // Matches Widget

                    const SliverToBoxAdapter(
                      child: MatchesWidget(),
                    ),

                    // Sources Widget

                    SliverToBoxAdapter(
                      child: SourcesListViewWidget(),
                    ),

                    // News Widget

                    NewsList()
                  ]),
                  if (state is LoadingGetMatchesState ||
                      state is LoadingGetNewsState ||
                      state is LoadingMatchDetailsState ||
                      state is LoadingGetNewsDetailsState)
                    Center(child: CustomLoadingDialog())
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
