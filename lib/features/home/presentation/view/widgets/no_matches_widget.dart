import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoMatchesTodayWidget extends StatelessWidget {
  const NoMatchesTodayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 105.h,
        width: double.infinity,
        child: const Center(child: Text(" 😔 عفوا لا توجد مباريات ")));
  }
}