import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamNameWidget extends StatelessWidget {
  final String teamName;
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