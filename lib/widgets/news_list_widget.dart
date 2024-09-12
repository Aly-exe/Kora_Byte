import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/constants/colors.dart';
import 'package:kora_news/screens/news_with_detailesscreen.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/services/get_news_states.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = GetNewsBloc.get(context);
    return BlocBuilder<GetNewsBloc, GetNewsStates>(builder: (context, state) {
      return cubit.newsList.isEmpty || state is LoadingGetNewsState
          ? SliverToBoxAdapter(
              child: Container(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorPallet.kNavyColor,
                  ),
                ),
              ),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: cubit.newsList.length, (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await cubit
                        .getDetailsNews(context, cubit.newsList[index].baseurl!,
                            cubit.newsList[index].href!)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsNewsScreen(
                                    title:
                                        cubit.detailesFilgoalNewsModel.title ?? cubit.newsList[index].title!,
                                    imagelink: cubit
                                        .detailesFilgoalNewsModel.imagelink??cubit.newsList[index].imagelink!,
                                    details: cubit
                                        .detailesFilgoalNewsModel.detailes?? "تعذر الحصول علي تفاصيل الخبر",
                                  )));
                    });
                  },
                  child: NewsCardWidget(
                    cubit: cubit,
                    index: index,
                  ),
                );
              }),
            );
    });
  }
}

class NewsCardWidget extends StatelessWidget {
  NewsCardWidget({super.key, required this.cubit, required this.index});

  final GetNewsBloc cubit;
  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                cubit.newsList[index].imagelink!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textDirection: TextDirection.rtl,
                    cubit.newsList[index].title!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
