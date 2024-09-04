import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      child: ScreenUtilInit(
        designSize: const Size(360, 756),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder:(context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Locale('ar'),
          title: 'Kora News',
          home: HomeScreen(),
        );
      }
      ),
    );
  }
}
