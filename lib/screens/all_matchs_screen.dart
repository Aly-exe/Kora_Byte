import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/constants/colors.dart';
import 'package:kora_news/screens/match_details_screen.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';
import 'package:kora_news/widgets/custom_dialog.dart';
import 'package:kora_news/widgets/matches_widget.dart';

class AllMatchs extends StatefulWidget {
  const AllMatchs({super.key});

  @override
  State<AllMatchs> createState() => _AllMatchsState();
}

class _AllMatchsState extends State<AllMatchs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Set height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff2412C0),
                Color(0xff4910BC)
              ], // Define your gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor:
                Colors.transparent, // Set AppBar background to transparent
            elevation: 0,
            title: Text(
              'All Matchs',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<GetNewsBloc, GetNewsStates>(
        builder: (context, state) {
          var cubit = GetNewsBloc.get(context);
          return cubit.matchesList.isEmpty
              ? Container(
                  height: 170.h,
                  width: double.infinity,
                  child: Center(
                      child: CustomLoadingDialog()))
              : Stack(
                children: [
                  ListView.builder(
                  itemCount: cubit.matchesList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await GetNewsBloc.get(context)
                            .getMatchDetails(Uri.decodeFull(
                                cubit.matchesList[index].matchhref))
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MatchDetailsScreen()));
                        }).catchError((error) {
                          print(error);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)
                        ),
                        margin: EdgeInsets.all(10),
                        height: 55.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Away Team Name
                            TeamNameWidget(
                              teamName: cubit.matchesList[index].awayTeam,
                            ),
                            // Away Team Image
                            TeamImageWidget(
                              imageUrl: cubit.matchesList[index].awayTeamimage!,
                            ),
                            
                            // Away Team Score
                            TeamScoreWidget(
                                teamScore: cubit.matchesList[index].awayScore),
                            SizedBox(
                              width: 7.w,
                            ),
                            // Some Info about Match (Start || Not Start || finished || Match Time)
                            Container(
                                width: 70.w,
                                height: cubit.matchesList[index].matchState ==
                                            "الشوط الأول" ||
                                        cubit.matchesList[index].matchState ==
                                            "الشوط الثاني" ||
                                        cubit.matchesList[index].matchState ==
                                            "استراحة"
                                    ? 30.h
                                    : 55.h,
                                decoration: BoxDecoration(
                                  color: cubit.matchesList[index].matchState ==
                                              "الشوط الأول" ||
                                          cubit.matchesList[index].matchState ==
                                              "الشوط الثاني" ||
                                          cubit.matchesList[index].matchState ==
                                              "استراحة"
                                      ? Color(0xffC00A0C)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: cubit.matchesList[index].matchState ==
                                        "انتهت"
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("انتهت"),
                                        ],
                                      )
                                    : cubit.matchesList[index].matchState ==
                                                "الشوط الأول" ||
                                            cubit.matchesList[index]
                                                    .matchState ==
                                                "الشوط الثاني" ||
                                            cubit.matchesList[index]
                                                    .matchState ==
                                                "استراحة"
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                cubit.matchesList[index]
                                                    .matchState,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.0),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                cubit.matchesList[index]
                                                    .matchState,
                                              ),
                                              Text(
                                                cubit.matchesList[index]
                                                    .matchTime,
                                              ),
                                            ],
                                          )),
                            SizedBox(
                              width: 7.w,
                            ),
                            // Home Team Score
                            TeamScoreWidget(
                                teamScore: cubit.matchesList[index].homeScore),
                            
                            // Home Team Image
                            TeamImageWidget(
                              imageUrl: cubit.matchesList[index].homeTeamimage!,
                            ),
                            
                            // Home Team Name
                            TeamNameWidget(
                              teamName: cubit.matchesList[index].homeTeam,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  if(state is LoadingDetailsMatchesState ) Center(child: CustomLoadingDialog(),) 
        
                ]
              );},
      ),
    );
  }
}
