import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class NewsWithDetails extends StatelessWidget {
  String title;
  String imagelink;
  String details;
  NewsWithDetails(
      {required this.title, required this.details, required this.imagelink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Set height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff2412C0),Color(0xff4910BC)], // Define your gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Set AppBar background to transparent
            elevation: 0,
            title: Text(
              'تفاصيل الخبر',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white,)
              ,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imagelink,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(details,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500 ,),
                      textDirection: TextDirection.rtl),
                ],
              )),
        ));
  }
}
