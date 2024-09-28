import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/features/home/presentation/view/match_details_screen.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';
import 'package:kora_news/core/widgets/custom_dialog.dart';
import 'package:kora_news/features/home/presentation/view/widgets/matches_widget.dart';

class AllMatchs extends StatefulWidget {
  const AllMatchs({super.key});

  @override
  State<AllMatchs> createState() => _AllMatchsState();
}

class _AllMatchsState extends State<AllMatchs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Set height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff2412C0),
                Color(0xff4910BC)
              ], // Define your gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor:
                Colors.transparent, // Set AppBar background to transparent
            elevation: 0,
            title: Text(
              'All Matchs',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 16.w,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<GetNewsBloc, GetNewsStates>(
        builder: (context, state) {
          var cubit = GetNewsBloc.get(context);
          return cubit.matchesList.isEmpty
              ? Container(
                  height: 170.h,
                  width: double.infinity,
                  child: Center(
                      child: CustomLoadingDialog()))
              : Stack(
                children: [
                  ListView.builder(
                  itemCount: cubit.matchesList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await GetNewsBloc.get(context)
                            .getMatchDetails(Uri.decodeFull(
                                cubit.matchesList[index].matchhref))
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MatchDetailsScreen()));
                        }).catchError((error) {
                          print(error);
                        });
                      },
                      child: FittedBox(
                        child: Container(
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)
                          ),
                          margin: EdgeInsets.all(10),
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
                              
                              // Away Team Score
                              TeamScoreWidget(
                                  teamScore: cubit.matchesList[index].awayScore),
                              SizedBox(
                                width: 7.w,
                              ),
                              // Some Info about Match (Start || Not Start || finished || Match Time)
                              FittedBox(
                                child: Container(
                                    // width: 70.w,
                                    width: max(65.w, 100.w),
                                    
                                    decoration: BoxDecoration(
                                      color: cubit.matchesList[index].matchState ==
                                                  "الشوط الأول" ||
                                              cubit.matchesList[index].matchState ==
                                                  "الشوط الثاني" ||
                                              cubit.matchesList[index].matchState ==
                                                  "استراحة"
                                          ? Color(0xffC00A0C)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: cubit.matchesList[index].matchState ==
                                            "انتهت"
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("انتهت", style: TextStyle(fontSize: 13.sp),),
                                            ],
                                          )
                                        : cubit.matchesList[index].matchState ==
                                                    "الشوط الأول" ||
                                                cubit.matchesList[index]
                                                        .matchState ==
                                                    "الشوط الثاني" ||
                                                cubit.matchesList[index]
                                                        .matchState ==
                                                    "استراحة"
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    cubit.matchesList[index]
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
                                                    cubit.matchesList[index]
                                                        .matchState,
                                                        style: TextStyle(fontSize: 12.sp),
                                                  ),
                                                  Text(
                                                    cubit.matchesList[index]
                                                        .matchTime,
                                                        style: TextStyle(fontSize: 12.sp),
                                                  ),
                                                ],
                                              )),
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              // Home Team Score
                              TeamScoreWidget(
                                  teamScore: cubit.matchesList[index].homeScore),
                              
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
                  }),
                  if(state is LoadingDetailsMatchesState ) Center(child: CustomLoadingDialog(),) 
        
                ]
              );},
      ),
    );
  }
}
