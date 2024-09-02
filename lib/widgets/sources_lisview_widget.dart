import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/models/sources_model.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';

class SourcesListViewWidget extends StatelessWidget {
  final List<Sources> sourcesList = [
    Sources(sourceName: "EPL", imagelink: "assets/images/EgplLogo.png"),
    Sources(sourceName: "FilGoal", imagelink: "assets/images/filgoallogo.jpg"),
    Sources(
        sourceName: "Yalla Kora", imagelink: "assets/images/yallkoralogo.jpg"),
    Sources(
        sourceName: "Kora Plus", imagelink: "assets/images/Korapluslogo.jpg"),
];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNewsBloc, GetNewsStates>(
      builder: (context, state) {
        var cubit = GetNewsBloc.get(context);
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 60,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await cubit.getNews(index);
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    width: 180,
                    child: Row(
                      children: [
                        Image.asset(
                          sourcesList[index].imagelink,
                          width: 62,
                          height: 60,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(sourcesList[index].sourceName),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  width: 10,
                  color: Colors.white,
                );
              },
              itemCount: sourcesList.length),
        );
      },
    );
  }
}
