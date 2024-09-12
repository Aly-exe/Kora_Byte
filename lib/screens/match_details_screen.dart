import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/constants/colors.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';

class MatchDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'تفاصيل المباراه',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body:
            BlocBuilder<GetNewsBloc, GetNewsStates>(builder: ((context, state) {
          var cubit = GetNewsBloc.get(context);

          return state is LoadingDetailsMatchesState
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorPallet.kNavyColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors
                            .grey[200], // Light background color for header
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        child: Column(
                          children: [
                            Text(cubit.matchinfo.championName!,
                                style: TextStyle(fontSize: 16)),
                            Text(cubit.matchinfo.round!,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            Text(
                              textDirection: TextDirection.rtl,
                                '${cubit.matchinfo.date.toString()}  _  ${cubit.matchinfo.time}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                      cubit.matchinfo.teamBimageLink!,
                                      width: 60,
                                      height: 60,
                                    ),
                                    Text(cubit.matchinfo.teamBname!,
                                        style: TextStyle(fontSize: 16)),
                                    Text('Away',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                Text(
                                  '${cubit.matchinfo.teamBscore} : ${cubit.matchinfo.teamAscore}',
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                      cubit.matchinfo.teamAimageLink!,
                                      width: 60,
                                      height: 60,
                                    ),
                                    Text(cubit.matchinfo.teamAname!,
                                        style: TextStyle(fontSize: 16)),
                                    Text('Home',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text('\'${cubit.matchinfo.matchState!}',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 16)),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      // Column(
                      //   children: [
                      //     Text("إحصائيات المباراه",
                      //         style: TextStyle(
                      //             fontSize: 24, fontWeight: FontWeight.w600)),
                      //     buildStatsTab(),
                      //   ],
                      // ),
                    ],
                  ),
                );
        })));
  }

  Widget buildStatsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildStatRow('الضربات الركنية', '7', '6'),
          buildStatRow('التسلل', '5', '2'),
          buildStatRow('التسديد على المرمى', '23', '23'),
          buildStatRow('الكروت الصفراء', '14', '9'),
          buildStatRow('الكروت الحمراء', '0', '0'),
        ],
      ),
    );
  }

  Widget buildStatRow(String stat, String teamAValue, String teamBValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(stat, style: TextStyle(fontSize: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(teamAValue, style: TextStyle(fontSize: 16)),
              SizedBox(width: 10),
              Container(
                width: 150,
                height: 10,
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor:
                          double.parse(teamAValue.replaceAll('%', '')) / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue, // Bar color for team A
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Text(teamBValue, style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
