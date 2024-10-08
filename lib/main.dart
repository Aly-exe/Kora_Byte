import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kora_news/core/helpers/dio_helper.dart';
import 'package:kora_news/features/home/presentation/view_model/get_matches/get_matches_cubit.dart';
import 'package:kora_news/firebase_options.dart';
import 'package:kora_news/features/home/presentation/view/homescreen.dart';
import 'package:kora_news/services/get_news_bloc.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var token = await FirebaseMessaging.instance.getToken();
  print("Firebase Message Token is $token}");
  FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  ScreenUtil.ensureScreenSize();
  await DioHelper.initDio();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation
        .portraitUp // That Make App Display At Portrait Mode not landScape Mode
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  void initState() {
    // TODO: implement initState
    super.initState();
    // Initialize local notifications
    // Creates Android-specific settings for initializing local notifications. The @mipmap/launcher_icon is the resource used as the notification icon.
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Configure FCM
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground message: ${message.notification?.title}');
      // Show a notification
      if (message.notification != null) {
        _showNotification(message.notification!);
      }
    });
  }

  Future<void> _showNotification(RemoteNotification notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(create: (context) => GetMatchesCubit()..getMatches()),
    ], child: ScreenUtilInit(
          designSize: const Size(360, 756),
          minTextAdapt: true,
          splitScreenMode: true,
          // Use builder only if you need to use library outside ScreenUtilInit context
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: Locale('ar'),
              title: 'Kora News',
              home: HomeScreen(),
            );
          }));
    // return BlocProvider(
    //   create: (context) => GetNewsBloc()
    //     ..getFilgoalNews()
    //     ..getMatches(),
    //   child: ScreenUtilInit(
    //       designSize: const Size(360, 756),
    //       minTextAdapt: true,
    //       splitScreenMode: true,
    //       // Use builder only if you need to use library outside ScreenUtilInit context
    //       builder: (context, child) {
    //         return MaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           locale: Locale('ar'),
    //           title: 'Kora News',
    //           home: HomeScreen(),
    //         );
    //       }),
    // );
  }
}
