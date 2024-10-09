import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit.dart';

class MatchStateWidget extends StatelessWidget {
  MatchStateWidget({
    super.key,
    required this.matchesCubit,
    required this.index
  });

  final GetMatchesCubit matchesCubit;
  final index;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: max(65.w, 100.w),
        decoration: BoxDecoration(
          color: matchesCubit.matchesList[index].matchState ==
                      "الشوط الأول" ||
                  matchesCubit.matchesList[index].matchState ==
                      "الشوط الثاني" ||
                  matchesCubit.matchesList[index].matchState ==
                      "استراحة"
              ? Color(0xffC00A0C)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: matchesCubit.matchesList[index].matchState ==
                "انتهت"
            ? Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text("انتهت", style: TextStyle(fontSize: 13.sp),),
                ],
              )
            : matchesCubit.matchesList[index].matchState ==
                        "الشوط الأول" ||
                    matchesCubit.matchesList[index]
                            .matchState ==
                        "الشوط الثاني" ||
                    matchesCubit.matchesList[index]
                            .matchState ==
                        "استراحة"
                ? Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        matchesCubit.matchesList[index]
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
                        matchesCubit.matchesList[index]
                            .matchState,
                            style: TextStyle(fontSize: 12.sp),
                      ),
                      Text(
                        matchesCubit.matchesList[index]
                            .matchTime,
                            style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ));
  }
}
