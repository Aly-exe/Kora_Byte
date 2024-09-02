import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/screens/news_with_detailesscreen.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';

class NewsCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = GetNewsBloc.get(context);
    return Expanded(
      child: BlocBuilder<GetNewsBloc, GetNewsStates>(builder: (context, state) {
        return state is LoadingFilgoalNewsState || state is LoadingGetNewsState
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemCount: cubit.newsList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await cubit
                          .getDetailsNews(
                              context,
                              cubit.newsList[index].baseurl!,
                              cubit.newsList[index].href!)
                          .then((value) {
                        log(cubit.newsList[index].href!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsWithDetails(
                                      title:
                                          cubit.detailesFilgoalNewsModel.title!,
                                      imagelink: cubit
                                          .detailesFilgoalNewsModel.imagelink!,
                                      details: cubit
                                          .detailesFilgoalNewsModel.detailes!,
                                    )));
                      });
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image.network(
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          cubit.newsList[index].imagelink!,
                          filterQuality: FilterQuality.high,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black, // Darker at the top left
                                Colors.black.withOpacity(.7),
                                Colors.black.withOpacity(
                                    0.5), // Darker at the bottom right
                              ],
                              stops: [
                                0.0,
                                0.9,
                                1.0
                              ], // Define stops for the gradient
                            ),
                            color: Colors.black.withOpacity(0.4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              maxLines: 2,
                              textDirection: TextDirection.rtl,
                              cubit.newsList[index].title!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
              );
      }),
    );
  }
}
