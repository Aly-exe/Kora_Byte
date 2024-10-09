import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/features/home/presentation/view/widgets/failure_team_image_widget.dart';

class TeamImageWidget extends StatelessWidget {
  final String imageUrl;
  TeamImageWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 30.w,
      height: MediaQuery.of(context).size.height >= 800 ? 40.h : 30.h,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => FailureImageWidget(),
    );
  }
}
