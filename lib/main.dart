import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kora_news/screens/homescreen.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:kora_news/shared/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.initDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetNewsBloc()..getFilgoalNews()..getMatches(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kora News',
        home: HomeScreen(),
      ),
    );
  }
}
