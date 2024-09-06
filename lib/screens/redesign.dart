import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NewsDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Action for back button
          },
        ),
        title: Text(
          'تفاصيل الخبر',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, // Align content to the right for RTL
          children: [
            Text(
              'مصدر من الأهلي يكشف لـ في الجول: استاد القاهرة يستضيف مواجهة كأس إنتركونتيننتال',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4xc4HEKTYSzgFhZVCkAbyIBMVaKRRE-mw7g&s', // Replace with your image URL
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'يستضيف استاد القاهرة مواجهة الأهلي في بطولة كأس إنتركونتيننتال المقرر لها 29 أكتوبر المقبل. وكان مصدر من النادي الأهلي قد كشف لـFilGoal.com عن إعفاء الفريق من خوض الدور التمهيدي لبطولة إنتركونتيننتال. وينتظر الأهلي مواجهة الفائز من مباراة العين الإماراتي أو أوكلاند يستضيف استاد القاهرة مواجهة الأهلي في بطولة كأس إنتركونتيننتال المقرر لها 29 أكتوبر المقبل. وكان مصدر من النادي الأهلي قد كشف لـFilGoal.com عن إعفاء الفريق من خوض الدور التمهيدي لبطولة إنتركونتيننتال. وينتظر الأهلي مواجهة الفائز من مباراة العين الإماراتي أو أوكلاند سيتي النيوزيلندي في الدور التمهيدي. وكشف مصدر من الأهلي لـ FilGoal.com "تم تحديد استاد القاهرة من أجل استضافة مباراة الفريق أمام..."',
              // textAlign: TextAlign.right,
              textDirection: TextDirection.rtl, // Ensure RTL text direction
              style: TextStyle(
                fontSize: 18,
                height: 1.5, // Line height for better readability
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
