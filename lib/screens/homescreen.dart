import 'dart:developer';

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kora_news/constants/constants.dart';
import 'package:kora_news/shared/dio_helper.dart';
import 'package:kora_news/widgets/matches_widget.dart';
import 'package:kora_news/widgets/news_card_widget.dart';
import 'package:kora_news/widgets/sources_lisview_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Korabyte'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MatchesWidget(),
            SourcesListViewWidget(),
            NewsCardWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        // await DioHelper.getData(Constants.filGaoal).then((value) {
        //   var body =BeautifulSoup(value.data).find("div" , class_:"main_body" )!.find("div" , id: "list-box")!.findAll("li");
        //   body.forEach((e) {
        //     log(e.find('h6')!.text.toString().trim());
        //     log(e.find('a')!.attributes['href'].toString());
        //     log(e.find('img')!.attributes['data-src'].toString());
        //   });
        // }).catchError((error) {});
      }),
    );
  }
}
