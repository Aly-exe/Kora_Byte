import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/core/constants/colors.dart';
import 'package:kora_news/features/home/presentation/view/widgets/days_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/match_card_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/no_matches_widget.dart';
import 'package:kora_news/features/home/presentation/view/widgets/view_all_matches_widget.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_states.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MatchesWidget extends StatelessWidget {
  const MatchesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMatchesCubit, GetMatchesStates>(
      builder: (context, state) {
        var cubit = GetMatchesCubit.get(context);
        return Column(
          children: [
            DaysWidget(cubit: cubit),
            Container(
                height: cubit.matchesList.length >= 3 ? 160.h : 105.h,
                width: double.infinity,
                child: state is LoadingGetMatchesState
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is FailureGetMatchesState
                        ? CannotFetshMatchesWidget()
                        : (cubit.matchesList.isEmpty && state is SuccessGetMatchesState)
                            ? NoMatchesTodayWidget()
                            : MatchCard(cubit: cubit)),
            // View All Matches Container
            if (cubit.matchesList.isNotEmpty) ViewAllMatchesWidget(cubit: cubit,)
          ],
        );
      },
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



class CannotFetshMatchesWidget extends StatelessWidget {
  const CannotFetshMatchesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 105.h,
        width: double.infinity,
        child: Center(child: Text("تعذر الحصول علي المباريات ")));
  }
}

class MatchesStateWidget extends StatelessWidget {
  const MatchesStateWidget({super.key, required this.cubit, required this.index});

  final GetMatchesCubit cubit;
  final index;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
          width: max(50.w, 100.w),
          decoration: BoxDecoration(
            color: cubit.matchesList[index].matchState == "الشوط الأول" ||
                    cubit.matchesList[index].matchState == "الشوط الثاني" ||
                    cubit.matchesList[index].matchState == "استراحة"
                ? Color(0xffC00A0C)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: cubit.matchesList[index].matchState == "انتهت"
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "انتهت",
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                )
              : cubit.matchesList[index].matchState == "الشوط الأول" ||
                      cubit.matchesList[index].matchState == "الشوط الثاني" ||
                      cubit.matchesList[index].matchState == "استراحة"
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cubit.matchesList[index].matchState,
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.0.sp),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          cubit.matchesList[index].matchState,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          cubit.matchesList[index].matchTime,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    )),
    );
  }
}
