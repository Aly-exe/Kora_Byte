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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff2412C0),Color(0xff4910BC)], // Define your gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    "assets/images/korabytelogo.png",
                    height: 50,
                    fit: BoxFit.cover,
                    
                ),
                Text('Korabyte',
                style: TextStyle(fontSize: 20, color: Colors.white),),
              ],
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Column(
        children: [
          MatchesWidget(),
          SourcesListViewWidget(),
          NewsCardWidget()
        ],
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
