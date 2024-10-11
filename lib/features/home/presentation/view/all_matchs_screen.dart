import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/features/home/presentation/view/match_details_screen.dart';
import 'package:kora_news/features/home/presentation/view/widgets/match_state_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/no_matches_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/team_image_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/team_name_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/team_score_widget.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_states.dart';
import 'package:kora_news/core/widgets/custom_dialog.dart';

class AllMatchs extends StatelessWidget {
  final GetMatchesCubit matchesCubit;
  const AllMatchs({super.key, required this.matchesCubit});
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
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<GetMatchesCubit, GetMatchesStates>(
        builder: ((context, state) {
          if (state is LoadingGetMatchesState || state is LoadingMatchDetailsState) {
            return Center(
              child: Container(
                  height: 170.h,
                  width: double.infinity,
                  child: Center(child: CustomLoadingDialog())),
            );
          } else if (state is SuccessGetMatchesState|| matchesCubit.matchesList.isNotEmpty) {
            return Stack(children: [
              ListView.builder(
                itemCount: matchesCubit.matchesList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await matchesCubit
                          .getMatchDetails(
                              matchesCubit.matchesList[index].matchhref)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MatchDetailsScreen(
                                    matchDetails: matchesCubit.matchDetails)));
                      });
                    },
                    child: FittedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        margin: EdgeInsets.all(10),
                        height: 55.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Away Team Name
                            TeamNameWidget(
                              teamName:
                                  matchesCubit.matchesList[index].awayTeam,
                            ),
                            // Away Team Image
                            TeamImageWidget(
                              imageUrl: matchesCubit
                                  .matchesList[index].awayTeamimage!,
                            ),

                            // Away Team Score
                            TeamScoreWidget(
                                teamScore:
                                    matchesCubit.matchesList[index].awayScore),
                            SizedBox(
                              width: 7.w,
                            ),
                            // Some Info about Match (Start || Not Start || finished || Match Time)
                            FittedBox(
                              child: MatchStateWidget(
                                matchesCubit: matchesCubit,
                                index: index,
                              ),
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            // Home Team Score
                            TeamScoreWidget(
                                teamScore:
                                    matchesCubit.matchesList[index].homeScore),

                            // Home Team Image
                            TeamImageWidget(
                              imageUrl: matchesCubit
                                  .matchesList[index].homeTeamimage!,
                            ),

                            // Home Team Name
                            TeamNameWidget(
                              teamName:
                                  matchesCubit.matchesList[index].homeTeam,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ]);
          } else {
            return NoMatchesTodayWidget();
          }
        }),
      ),
    );
  }
}
