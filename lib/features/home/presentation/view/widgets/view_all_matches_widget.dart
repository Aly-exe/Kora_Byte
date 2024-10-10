import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/features/home/presentation/view/all_matchs_screen.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit.dart';

class ViewAllMatchesWidget extends StatelessWidget {
  const ViewAllMatchesWidget({
    super.key,
    required this.cubit
  });
  final GetMatchesCubit cubit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => AllMatchs(matchesCubit: cubit,))));
      },
      child: Container(
        width: 300.w,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_soccer,
              color: Colors.black,
              size: 25.w,
            ),
            SizedBox(width: 10),
            Text(
              'View All Matches',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
