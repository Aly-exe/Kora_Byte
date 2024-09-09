import 'package:flutter/material.dart';

class KoraByteAppBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Container(
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
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/korabytelogo.png",
              height: 50,
              fit: BoxFit.cover,
            ),
            Text(
              'Korabyte',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
      ),
    );
        
  }
}

