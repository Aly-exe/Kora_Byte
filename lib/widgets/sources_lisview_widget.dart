import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/constants/colors.dart';
import 'package:kora_news/models/sources_model.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';

class SourcesListViewWidget extends StatelessWidget {
  final List<Sources> sourcesList = [
    Sources(sourceName: "EPL", imagelink: "assets/images/EgplLogo.png"),
    Sources(sourceName: "FilGoal", imagelink: "assets/images/filgoallogo.jpg"),
    Sources(
        sourceName: "YallaKora", imagelink: "assets/images/yallkoralogo.jpg"),
    Sources(
        sourceName: "KoraPlus", imagelink: "assets/images/Korapluslogo.jpg"),
    Sources(
        sourceName: "Btolat", imagelink: "assets/images/btolat.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNewsBloc, GetNewsStates>(
      builder: (context, state) {
        var cubit = GetNewsBloc.get(context);
        return Container(
          margin:EdgeInsets.symmetric(vertical: 10.h),
          height: 60.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    cubit.changeSourceIndex(index);
                    await cubit.getNews(index);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0.w),
                      border: Border.all(color:index==cubit.sourceCurrentIndex?ColorPallet.kNavyColor.withOpacity(.6): Colors.black87),
                      // color:index==cubit.sourceCurrentIndex?ColorPallet.kNavyColor:Colors.transparent
                      gradient: index==cubit.sourceCurrentIndex? ColorPallet.linearGradient: LinearGradient(colors: [Colors.white , Colors.white])
                    ),
                    width: index==0 ? 120.w: 130.w,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0.w),
                            child: Image.asset(
                              sourcesList[index].imagelink,
                              width: 45.w,
                              height: 50.h,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                        Text(sourcesList[index].sourceName ,style: TextStyle(color:index==cubit.sourceCurrentIndex? Colors.white: Colors.black,fontWeight: FontWeight.w500), ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: sourcesList.length),
        );
      },
    );
  }
}
