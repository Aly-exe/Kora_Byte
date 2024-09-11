import 'package:flutter/material.dart';
import 'package:kora_news/constants/colors.dart';

class KoraByteAppBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
    return  Container(
      decoration: BoxDecoration(
        gradient: ColorPallet.linearGradient,
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

