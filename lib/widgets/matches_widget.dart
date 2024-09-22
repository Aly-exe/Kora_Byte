// ignore_for_file: must_be_immutable
import 'dart:math';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/constants/colors.dart';
import 'package:kora_news/constants/constants.dart';
import 'package:kora_news/screens/all_matchs_screen.dart';
import 'package:kora_news/screens/match_details_screen.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
            DaysWidget(cubit: cubit),
            Container(
              height: cubit.matchesList.length >= 3 ? 160.h : 105.h,
              width: double.infinity,
              child: state is LoadingMatchesState
                  ? MatchCard(cubit: cubit)
                  : state is FailedGetMatchesState
                      ? CannotFetshMatchesWidget()
                      : state is SucccesGetMatchesState &&
                              cubit.matchesList.isEmpty
                          ? NoMatchesTodayWidget()
                          : MatchCard(cubit: cubit),
            ),
            // View All Matches Container
            if (cubit.newsList.isNotEmpty) ViewAllMatchesWidget()
          ],
        );
      },
    );
  }
}

class DaysWidget extends StatelessWidget {
  const DaysWidget({
    super.key,
    required this.cubit,
  });

  final GetNewsBloc cubit;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0.h),
        child: CustomSlidingSegmentedControl(
            initialValue: 2,
            innerPadding: EdgeInsets.all(0),
            children: {
              1: Text('أمس' ,style: TextStyle(color: Colors.white , fontSize: 12.sp),),
              2: Text('اليوم',style: TextStyle(color: Colors.white, fontSize: 12.sp)),
              3: Text('غدا',style: TextStyle(color: Colors.white, fontSize: 12.sp)),
            },
            decoration: BoxDecoration(
              // color: Colors.red,
              gradient: ColorPallet.linearGradientTwo,
    
              borderRadius: BorderRadius.circular(20),
            ),
            thumbDecoration: BoxDecoration(
              color: Color(0xffF5A54F),
              borderRadius: BorderRadius.circular(20),
            ),
            onValueChanged: (index) async {
              switch (index) {
                case 1:
                  await cubit.getMatches(
                      link: Constants.yallaKoraMatchesYesterday);
                  break;
                case 2:
                  await cubit.getMatches(
                      link: Constants.yallaKoraMatches);
                  break;
                case 3:
                  await cubit.getMatches(
                      link: Constants.yallaKoraMatchesNextDay);
                  break;
              }
            }),
      ),
    );
  }
}


class CircleIndicatorWidget extends StatelessWidget {
  const CircleIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 170.h,
        width: double.infinity,
        child: Center(
            child: CircularProgressIndicator(
          color: ColorPallet.kNavyColor,
        )));
  }
}

class NoMatchesTodayWidget extends StatelessWidget {
  const NoMatchesTodayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
          height: 170.h,
          width: double.infinity,
          child: Center(child: Text(" 😔 عفوا لا توجد مباريات "))),
    );
  }
}

class CannotFetshMatchesWidget extends StatelessWidget {
  const CannotFetshMatchesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
          height: 170.h,
          width: double.infinity,
          child: Center(child: Text("تعذر الحصول علي المباريات "))),
    );
  }
}

class ViewAllMatchesWidget extends StatelessWidget {
  const ViewAllMatchesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => AllMatchs())));
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
            Icon(Icons.sports_soccer, color: Colors.black ,size: 25.w,),
            SizedBox(width: 10),
            Text(
              'View All Matches',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
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
    return Skeletonizer(
      enabled: widget.cubit.matchesIsLoading,
      child: ListView.builder(
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
                //log("Passed Url from Medole \n ${widget.cubit.matchesList[index].matchhref}");
                await GetNewsBloc.get(context)
                    .getMatchDetails(Uri.decodeFull(
                        widget.cubit.matchesList[index].matchhref))
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MatchDetailsScreen()));
                }).catchError((error) {
                 // log(error);
                });
              },
              child: FittedBox(
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
                      MatchStateWidget(widget: widget , index: index,),
                
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
              ),
            );
          }),
    );
  }
}

class MatchStateWidget extends StatelessWidget {
   MatchStateWidget({
    super.key,
    required this.widget,
    required this.index
  });

  final MatchCard widget;
  int index;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
          width: max(50.w, 100.w),
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
                    Text("انتهت"  , style: TextStyle(fontSize: 12.sp,),),
                  ],
                )
              : widget.cubit.matchesList[index].matchState ==
                          "الشوط الأول" ||
                      widget.cubit.matchesList[index]
                              .matchState ==
                          "الشوط الثاني" ||
                      widget.cubit.matchesList[index]
                              .matchState ==
                          "استراحة"
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.cubit.matchesList[index]
                              .matchState,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0.sp),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.cubit.matchesList[index]
                              .matchState,
                              style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          widget
                              .cubit.matchesList[index].matchTime,
                              style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    )),
    );
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
        style: TextStyle(fontSize: 13.sp),
      
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
      height: MediaQuery.of(context).size.height>=800 ? 40.h :30.h,
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
        style: TextStyle(fontSize: 13.sp),
      ),
    );
  }
}
