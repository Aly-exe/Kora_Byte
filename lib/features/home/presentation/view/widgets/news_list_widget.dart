import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/features/home/presentation/view/news_details_screen.dart';
import 'package:kora_news/features/home/presentation/view/widgets/failure_team_image_widget.dart';
import 'package:kora_news/features/home/presentation/view_model/get_news/get_new_cubit.dart';
import 'package:kora_news/features/home/presentation/view_model/get_news/get_news_states.dart';

import 'package:skeletonizer/skeletonizer.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = GetNewsCubit.get(context);
    return BlocBuilder<GetNewsCubit, GetNewsStates>(builder: (context, state) {
      return (state is FailedGetNewsState)
          ? SliverToBoxAdapter(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 120.h, horizontal: 95.w),
                child: Container(
                  child: Text(
                    "تعذر الحصول علي الاخبار",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              ),
            )
          : Skeletonizer.sliver(
              // enabled: state is LoadingFilgoalNewsState?true :cubit.newsIsLoading,
              enabled: false,
              child: SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: cubit.newsList.length, (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await cubit.getNewsDetails(baseUrl:cubit.newsList[index].baseurl!,url: cubit.newsList[index].href!).then((value) {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> NewsDetailsScreen(
                          title: cubit.newsDetails.title!,
                          imagelink: cubit.newsDetails.imagelink!,
                          details: cubit.newsDetails.details!,
                        )));
                      });
                      // await cubit
                      //     .getDetailsNews(context, cubit.newsList[index].baseurl!,
                      //         cubit.newsList[index].href!)
                      //     .then((value) {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => DetailsNewsScreen(
                      //                 title: cubit.detailesFilgoalNewsModel.title ??
                      //                     cubit.newsList[index].title!,
                      //                 imagelink:
                      //                     cubit.detailesFilgoalNewsModel.imagelink ??
                      //                         cubit.newsList[index].imagelink!,
                      //                 details:
                      //                     cubit.detailesFilgoalNewsModel.detailes ??
                      //                         "تعذر الحصول علي تفاصيل الخبر",
                      //               )));
                      // });
                    },
                    child: NewsCardWidget(
                      cubit: cubit,
                      index: index,
                    ),
                  );
                }),
              ),
            );
    });
  }
}

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({super.key, required this.cubit, required this.index});

  final GetNewsCubit cubit;
  final index;

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
                child: CachedNetworkImage(
                  imageUrl: cubit.newsList[index].imagelink!,
                  errorWidget: (context, url, error) => FailureImageWidget(),
                  height: MediaQuery.of(context).size.height >= 800 ? 300 : 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textDirection: TextDirection.rtl,
                    cubit.newsList[index].title!,
                    style: TextStyle(
                      fontSize: 16.sp,
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
