import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/features/home/presentation/view/widgets/matches_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/team_image_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/team_name_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/team_score_widget.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({
    super.key,
    required this.cubit,
  });

  final GetMatchesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.matchesList.length >= 3
            ? 3
            : cubit.matchesList.length >= 2
                ? 2
                : cubit.matchesList.length >= 1
                    ? 1
                    : 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              //log("Passed Url from Medole \n ${widget.cubit.matchesList[index].matchhref}");
              // await GetNewsBloc.get(context)
              //     .getMatchDetails(Uri.decodeFull(
              //         widget.cubit.matchesList[index].matchhref))
              //     .then((value) {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => MatchDetailsScreen()));
              // }).catchError((error) {
              //   // log(error);
              // });
            },
            child: FittedBox(
              child: Container(
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
                    SizedBox(
                      width: 10.w,
                    ),
                    // Away Team Score
                    TeamScoreWidget(
                        teamScore: cubit.matchesList[index].awayScore),
                    SizedBox(
                      width: 5.w,
                    ),
                    // Some Info about Match (Start || Not Start || finished || Match Time)
                    MatchesStateWidget(
                      cubit: cubit,
                      index: index,
                    ),

                    SizedBox(
                      width: 5.w,
                    ),
                    // Home Team Score
                    TeamScoreWidget(
                        teamScore:  cubit.matchesList[index].homeScore),
                    SizedBox(
                      width: 10.w,
                    ),
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
            ),
          );
        });
  }
}
