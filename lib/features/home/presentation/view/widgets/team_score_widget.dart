import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamScoreWidget extends StatelessWidget {
  final String teamScore;
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