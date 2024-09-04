import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/constants/colors.dart';
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
        return cubit.matchesList
                .isEmpty //state is LoadingMatchesState || state is FailedGetMatchesState ||
            ? Container(
                height: 170.h,
                width: double.infinity,
                child: Center(child: ProgressIndicator()))
            : Column(
                children: [
                  Container(
                    height: 170.h,
                    width: double.infinity,
                    child: MatchCard(cubit: cubit),
                  ),
                  //Text("كل المباريات")
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
  Color color1 = Color.fromARGB(239, 220, 7, 7);
  Color color2 = Color.fromARGB(236, 209, 20, 20);
  Color? currentColor = Color.fromARGB(239, 220, 7, 7);
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentColor == Color.fromARGB(239, 220, 7, 7)
            ? currentColor = color2
            : currentColor = color1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
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
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: widget.cubit.matchesList[index].matchState ==
                                  "الشوط الأول" ||
                              widget.cubit.matchesList[index].matchState ==
                                  "الشوط الثاني" ||
                              widget.cubit.matchesList[index].matchState ==
                                  "استراحة"
                          ? currentColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: widget.cubit.matchesList[index].matchState == "انتهت"
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
                                    widget.cubit.matchesList[index].matchState,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.cubit.matchesList[index].matchState,
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
