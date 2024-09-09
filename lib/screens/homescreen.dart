import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kora_news/widgets/custom_appbar.dart';
import 'package:kora_news/widgets/matches_widget.dart';
import 'package:kora_news/widgets/news_list_widget.dart';
import 'package:kora_news/widgets/sources_lisview_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60), child: KoraByteAppBar()),

        // <<<<<<<<<<<<<<< Body >>>>>>>>>>>>

        body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
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
        ]));
  }
}
