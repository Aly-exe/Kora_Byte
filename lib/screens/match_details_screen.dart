import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/constants/colors.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';

class MatchDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNewsBloc, GetNewsStates>(
      builder: (context, state) {
        var cubit = GetNewsBloc.get(context);
        return Scaffold(
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
                  backgroundColor: Colors
                      .transparent, // Set AppBar background to transparent
                  elevation: 0,
                  title: Text(
                    'تفاصيل المباراه',
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
                      cubit.matchinfo.teamAScorePlayers.clear();
                      cubit.matchinfo.teamBScorePlayers.clear();
                      cubit.matchinfo.teamAScoreTimes.clear();
                      cubit.matchinfo.teamBScoreTimes.clear();

                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            body: state is LoadingDetailsMatchesState
                ? Center(
                    child: CircularProgressIndicator(
                      color: ColorPallet.kNavyColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        //info
                        Container(
                          width: double.infinity,
                          color: Colors.grey[200],
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 16.w),
                          child: Column(children: [
                            Text(cubit.matchinfo.championName!,
                                style: TextStyle(fontSize: 16.sp)),
                            Text(cubit.matchinfo.round!,
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey)),
                            Text(
                                textDirection: TextDirection.rtl,
                                '${cubit.matchinfo.date.toString()}  _  ${cubit.matchinfo.time}',
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey)),
                            SizedBox(height: 5.h),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.tv),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    cubit.matchinfo.tvChannels!,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text('\'${cubit.matchinfo.matchState!}',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 16)),
                            SizedBox(height: 15.h),
                          ]),
                        ),
                        // Team A crad
                        SizedBox(
                          height: 25.h,
                        ),
                        teamCard(
                            teamstate: "Home",
                            teamName: cubit.matchinfo.teamAname!,
                            teamScore: cubit.matchinfo.teamAscore!,
                            teamimageLink: cubit.matchinfo.teamAimageLink!,
                            scorerPlayersList:
                                cubit.matchinfo.teamAScorePlayers,
                            goalsTimesList: cubit.matchinfo.teamAScoreTimes),
                        SizedBox(
                          height: 10.h,
                        ),

                        teamCard(
                            teamstate: "Away",
                            teamName: cubit.matchinfo.teamBname!,
                            teamScore: cubit.matchinfo.teamBscore!,
                            teamimageLink: cubit.matchinfo.teamBimageLink!,
                            scorerPlayersList:
                                cubit.matchinfo.teamBScorePlayers,
                            goalsTimesList: cubit.matchinfo.teamBScoreTimes)
                      ],
                    ),
                  ));
      },
    );
  }
}

Widget teamCard({
  required String teamstate,
  required String teamName,
  required String teamScore,
  required String teamimageLink,
  required List scorerPlayersList,
  required List goalsTimesList,
}) {
  return Container(
    color: Colors.grey[200],
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(teamstate)],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Image.network(
              teamimageLink,
              width: 80.w,
              height: 80.h,
            ),
            Spacer(),
            Text(
              teamScore,
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Row(children: [
          Container(
              width: 80.w,
              child: Text(teamName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 18.sp, overflow: TextOverflow.ellipsis))),
        ]),
        scorerPlayersList.length == 0
            ? SizedBox()
            : scorerPlayersList.length == 1
                ? ScorePlayer(
                    playerName: scorerPlayersList[0],
                    goalsTimes: goalsTimesList[0].toString())
                : Column(
                    children: [
                      Container(
                        height: scorerPlayersList.length * 30.h,
                        child: ListView.builder(
                            itemCount: scorerPlayersList.length,
                            itemBuilder: (context, index) {
                              return ScorePlayer(
                                  playerName: scorerPlayersList[index],
                                  goalsTimes: goalsTimesList[index].toString());
                            }),
                      )
                    ],
                  )
      ]),
    ),
  );
}

Widget ScorePlayer({
  required String playerName,
  required String goalsTimes,
}) {
  return Container(
    height: 25,
    width: double.infinity,
    child: Row(
      textDirection: TextDirection.rtl,
      children: [
        Text(
          playerName,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(goalsTimes, overflow: TextOverflow.ellipsis)
      ],
    ),
  );
}
