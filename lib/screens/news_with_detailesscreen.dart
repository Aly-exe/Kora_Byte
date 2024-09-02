import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: Text("تفاصيل الخبر"),
          centerTitle: true,
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
                  Image.network(
                    imagelink,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 30),
                  Text(details,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      textDirection: TextDirection.rtl),
                ],
              )),
        ));
  }
}
