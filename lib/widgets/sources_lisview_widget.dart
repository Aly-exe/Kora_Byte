import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNewsBloc, GetNewsStates>(
      builder: (context, state) {
        var cubit = GetNewsBloc.get(context);
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 60,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await cubit.getNews(index);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.black87),
                    ),
                    width: index==0 ? 120: 130,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.asset(
                              sourcesList[index].imagelink,
                              width: 45,
                              height: 50,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                        Text(sourcesList[index].sourceName ,style: TextStyle(fontWeight: FontWeight.w500), ),
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
