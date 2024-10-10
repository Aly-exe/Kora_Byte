import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/core/constants/colors.dart';
import 'package:kora_news/core/constants/constants.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit.dart';

class DaysWidget extends StatelessWidget {
  const DaysWidget({
    super.key,
    required this.cubit,
  });

  final GetMatchesCubit cubit;

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
              1: Text(
                'أمس',
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
              2: Text('اليوم',
                  style: TextStyle(color: Colors.white, fontSize: 12.sp)),
              3: Text('غدا',
                  style: TextStyle(color: Colors.white, fontSize: 12.sp)),
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
                      matchday: Constants.yallaKoraMatchesYesterday);
                  break;
                case 2:
                  await cubit.getMatches(matchday: Constants.yallaKoraMatches);
                  break;
                case 3:
                  await cubit.getMatches(
                      matchday: Constants.yallaKoraMatchesNextDay);
                  break;
              }
            }),
      ),
    );
  }
}
