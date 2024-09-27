import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/core/constants/colors.dart';

class CustomLoadingDialog extends StatelessWidget {
  const CustomLoadingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      width: 150.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0.w),
        color: ColorPallet.kNavyColor.withOpacity(.5)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
        Image.asset("assets/images/korabytelogo.png" ,width: 100.w, ),
        SizedBox(height: 5.h,),
        CircularProgressIndicator(color: Colors.white,),
        SizedBox(height: 10.0.h,),
        Text("...جاري التحميل",style: TextStyle(fontSize: 18.0.sp ,color: Colors.white),)
      ],),
    ),);
  }
}
