import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/core/widgets/custom_dialog.dart';
import 'package:kora_news/features/home/data/models/match_details_model.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_states.dart';

class MatchDetailsScreen extends StatelessWidget {
  

        final MatchDetails matchDetails;

  const MatchDetailsScreen({super.key, required this.matchDetails});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMatchesCubit, GetMatchesStates>(
      builder: (context, state) {
        var cubit = GetMatchesCubit.get(context);
        print(matchDetails.teamAname);
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
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
                        fontSize: 16.sp),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 16.w,
                    ),
                    onPressed: () {
                      cubit.matchDetails.teamAScorePlayers.clear();
                      cubit.matchDetails.teamBScorePlayers.clear();
                      cubit.matchDetails.teamAScoreTimes.clear();
                      cubit.matchDetails.teamBScoreTimes.clear();

                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            body: 
            // state is LoadingMatchDetailsState
                matchDetails.championName==null? Center(
                    child: Container(
                        height: 170.h,
                        width: double.infinity,
                        child: Center(child: CustomLoadingDialog())),
                  )
                :SingleChildScrollView(
                    child: Column(
                      children: [
                        //info
                        Container(
                          width: double.infinity,
                          color: Colors.grey[200],
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 16.w),
                          child: Column(children: [
                            Text(matchDetails.championName!,
                                style: TextStyle(fontSize: 16.sp)),
                            Text(matchDetails.round!,
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey)),
                            Text(
                                textDirection: TextDirection.rtl,
                                '${matchDetails.date.toString()}  _  ${matchDetails.time}',
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey)),
                            SizedBox(height: 5.h),
                            if (matchDetails.tvChannels !=
                                "لا توجد قنوات ناقله")
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
                                      matchDetails.tvChannels!,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontSize: 14.sp, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(height: 10.h),
                            Text('\'${matchDetails.matchState!}',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 14.sp)),
                            SizedBox(height: 15.h),
                          ]),
                        ),
                        // Team A crad
                        SizedBox(
                          height: 25.h,
                        ),
                        teamCard(
                            teamstate: "Home",
                            teamName: matchDetails.teamAname!,
                            teamScore: matchDetails.teamAscore!,
                            teamimageLink: matchDetails.teamAimageLink!,
                            scorerPlayersList: matchDetails.teamAScorePlayers,
                            goalsTimesList: matchDetails.teamAScoreTimes),
                        SizedBox(
                          height: 10.h,
                        ),

                        teamCard(
                            teamstate: "Away",
                            teamName: matchDetails.teamBname!,
                            teamScore: matchDetails.teamBscore!,
                            teamimageLink: matchDetails.teamBimageLink!,
                            scorerPlayersList: matchDetails.teamBScorePlayers,
                            goalsTimesList: matchDetails.teamBScoreTimes)
                      ],
                    ),
                  )
                  );
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
          children: [
            Text(
              teamstate,
              style: TextStyle(fontSize: 14.sp),
            )
          ],
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
                  textDirection: TextDirection.rtl,
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
