import 'package:flutter/material.dart';

class MatchesWidget extends StatelessWidget {
  const MatchesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/staduim.jpg") ,fit: BoxFit.cover)
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 10),
        child: Row(

          children: [
            Container(width: 45, child: Text("مانشستر يونايتد")),
            SizedBox(
              width: 5,
            ),
            Image.asset(
              "assets/images/man.png",
              width: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Not Start"),
                SizedBox(
                  height: 5,
                ),
                Text("10:00"),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Image.asset(
              "assets/images/barca.png",
              width: 40,
            ),
            SizedBox(
              width: 5,
            ),
            Container(width: 45, child: Text("برشلونه")),
          ],
        ),
      ),
    );
  }
}
