import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/core/constants/colors.dart';
import 'package:kora_news/features/home/data/repos/home_repo.dart';
import 'package:kora_news/features/home/data/repos/home_repo_implementation.dart';
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
    return Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () async {
        //   HomeRpeoImplementation homeRepo = HomeRpeoImplementation();
        //   await homeRepo.getMatches();
        // }),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60), child: KoraByteAppBar()),
        // <<<<<<<<<<<<<<< Body >>>>>>>>>>>>
        body: BlocBuilder<GetNewsBloc, GetNewsStates>(
          builder: (context, state) {
            return RefreshIndicator(
              color: ColorPallet.kNavyColor,
              onRefresh: () async {
                await GetNewsBloc.get(context).getMatches();
                await GetNewsBloc.get(context)
                    .getNews(GetNewsBloc.get(context).sourceCurrentIndex);
              },
              child: Stack(
                children: [
                  CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
                    // Matches Widget

                    SliverToBoxAdapter(
                      child: MatchesWidget(),
                    ),

                    // Sources Widget

                    SliverToBoxAdapter(
                      child: SourcesListViewWidget(),
                    ),

                    // News Widget

                    NewsList()
                  ]),
                  if (state is LoadingDetailsNewsState ||
                      state is LoadingDetailsMatchesState)
                    CustomLoadingDialog()
                ],
              ),
            );
          },
        ));
  }
}