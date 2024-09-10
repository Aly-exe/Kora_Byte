// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/constants/colors.dart';
import 'package:kora_news/constants/constants.dart';
import 'package:kora_news/models/match_details_model.dart';
import 'package:kora_news/screens/all_matchs_screen.dart';
import 'package:kora_news/screens/match_details_screen.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';

class MatchesWidget extends StatelessWidget {
  const MatchesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNewsBloc, GetNewsStates>(
      builder: (context, state) {
        var cubit = GetNewsBloc.get(context);
        return Column(
          children: [
            Container(
              width: 150.w,
              height: 40.h,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          cubit.changeCurrentindex(0);
                          await cubit.getMatches(
                              link: Constants.yallaKoraMatchesYesterday);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: BorderDirectional(
                                  bottom: BorderSide(
                            color: cubit.currentindex == 0
                                ? ColorPallet.kNavyColor
                                : Colors.transparent,
                          ))),
                          alignment: Alignment.centerRight,
                          width: 30.w,
                          child: Text("أمس"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 1.h,
                        color: Colors.black,
                        height: 25.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          cubit.changeCurrentindex(1);
                          await cubit.getMatches(
                              link: Constants.yallaKoraMatches);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: BorderDirectional(
                                  bottom: BorderSide(
                            color: cubit.currentindex == 1
                                ? ColorPallet.kNavyColor
                                : Colors.transparent,
                          ))),
                          alignment: Alignment.center,
                          width: 50.w,
                          child: Text("اليوم"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 1.h,
                        color: Colors.black,
                        height: 25.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          cubit.changeCurrentindex(2);
                          await cubit.getMatches(
                              link: Constants.yallaKoraMatchesNextDay);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: BorderDirectional(
                                  bottom: BorderSide(
                            color: cubit.currentindex == 2
                                ? ColorPallet.kNavyColor
                                : Colors.transparent,
                          ))),
                          padding: EdgeInsets.only(right: 7.w),
                          alignment: Alignment.centerRight,
                          width: 30.w,
                          child: Text("غدا"),
                        ),
                      ),
                    ]),
              ),
            ),
            Container(
              height: cubit.matchesList.length >= 3 ? 160.h : 105.h,
              width: double.infinity,
              child: state
                      is LoadingMatchesState // || state is FailedGetMatchesState || cubit.matchesList.isEmpty ||
                  ? Container(
                      height: 170.h,
                      width: double.infinity,
                      child: Center(child: ProgressIndicator()))
                  : state is SucccesGetMatchesState &&
                          cubit.matchesList.isNotEmpty
                      ? MatchCard(cubit: cubit)
                      : cubit.matchesList.isEmpty &&
                              state is SucccesGetMatchesState
                          ? Container(
                              height: 170.h,
                              width: double.infinity,
                              child:
                                  Center(child: Text("لا توجد مباريات اليوم")))
                          : SizedBox(),
            ),
            // View All Matches Container
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AllMatchs())));
              },
              child: Container(
                width: 300.w,
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sports_soccer, color: Colors.black),
                    SizedBox(width: 10),
                    Text(
                      'View All Matches',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: ColorPallet.kNavyColor,
    );
  }
}

class MatchCard extends StatefulWidget {
  const MatchCard({
    super.key,
    required this.cubit,
  });

  final GetNewsBloc cubit;

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.cubit.matchesList.length >= 3
            ? 3
            : widget.cubit.matchesList.length >= 2
                ? 2
                : widget.cubit.matchesList.length >= 1
                    ? 1
                    : 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              log("Passed Url from Medole \n ${widget.cubit.matchesList[index].matchhref}");
              await GetNewsBloc.get(context)
                  .getMatchDetails(
                      Uri.decodeFull(widget.cubit.matchesList[index].matchhref))
                  .then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MatchDetailsScreen()));
              }).catchError((error) {
                log(error);
              });
            },
            child: Container(
              height: 55.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Away Team Name
                  TeamNameWidget(
                    teamName: widget.cubit.matchesList[index].awayTeam,
                  ),
                  // Away Team Image
                  TeamImageWidget(
                    imageUrl: widget.cubit.matchesList[index].awayTeamimage!,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  // Away Team Score
                  TeamScoreWidget(
                      teamScore: widget.cubit.matchesList[index].awayScore),
                  SizedBox(
                    width: 5.w,
                  ),
                  // Some Info about Match (Start || Not Start || finished || Match Time)
                  Container(
                      width: 75.w,
                      height: widget.cubit.matchesList[index].matchState ==
                                  "الشوط الأول" ||
                              widget.cubit.matchesList[index].matchState ==
                                  "الشوط الثاني" ||
                              widget.cubit.matchesList[index].matchState ==
                                  "استراحة"
                          ? 30.h
                          : 55.h,
                      decoration: BoxDecoration(
                        color: widget.cubit.matchesList[index].matchState ==
                                    "الشوط الأول" ||
                                widget.cubit.matchesList[index].matchState ==
                                    "الشوط الثاني" ||
                                widget.cubit.matchesList[index].matchState ==
                                    "استراحة"
                            ? Color(0xffC00A0C)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: widget.cubit.matchesList[index].matchState ==
                              "انتهت"
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("انتهت"),
                              ],
                            )
                          : widget.cubit.matchesList[index].matchState ==
                                      "الشوط الأول" ||
                                  widget.cubit.matchesList[index].matchState ==
                                      "الشوط الثاني" ||
                                  widget.cubit.matchesList[index].matchState ==
                                      "استراحة"
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget
                                          .cubit.matchesList[index].matchState,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13.0),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget
                                          .cubit.matchesList[index].matchState,
                                    ),
                                    Text(
                                      widget.cubit.matchesList[index].matchTime,
                                    ),
                                  ],
                                )),

                  SizedBox(
                    width: 5.w,
                  ),
                  // Home Team Score
                  TeamScoreWidget(
                      teamScore: widget.cubit.matchesList[index].homeScore),
                  SizedBox(
                    width: 10.w,
                  ),
                  // Home Team Image
                  TeamImageWidget(
                    imageUrl: widget.cubit.matchesList[index].homeTeamimage!,
                  ),

                  // Home Team Name
                  TeamNameWidget(
                    teamName: widget.cubit.matchesList[index].homeTeam,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class TeamNameWidget extends StatelessWidget {
  String teamName;
  TeamNameWidget({required this.teamName});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 75.w,
      child: Text(
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        teamName,
        maxLines: 2,
        overflow: TextOverflow.clip,
      ),
    );
  }
}

class TeamImageWidget extends StatelessWidget {
  String imageUrl;
  TeamImageWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 30.h,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset("assets/images/korabyte.png");
        },
      ),
    );
  }
}

class TeamScoreWidget extends StatelessWidget {
  String teamScore;
  TeamScoreWidget({required this.teamScore});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 20.w,
      child: Text(
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        teamScore,
      ),
    );
  }
}
