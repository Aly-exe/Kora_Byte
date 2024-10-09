import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FailureImageWidget extends StatelessWidget {
  Widget build(context) {
    return Image.asset(
      "assets/images/korabyte.png",
      width: 30.w,
      height: MediaQuery.of(context).size.height >= 800 ? 40.h : 30.h,
      fit: BoxFit.cover,
    );
  }
}