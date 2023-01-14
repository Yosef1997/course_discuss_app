import 'package:course_discuss_app/config/app_color.dart';
import 'package:course_discuss_app/config/app_route.dart';
import 'package:course_discuss_app/controller/c_account.dart';
import 'package:course_discuss_app/controller/c_explore.dart';
import 'package:course_discuss_app/controller/c_feed.dart';
import 'package:course_discuss_app/controller/c_home.dart';
import 'package:course_discuss_app/controller/c_my_topic.dart';
import 'package:course_discuss_app/controller/c_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CUser()),
        ChangeNotifierProvider(create: (_) => CHome()),
        ChangeNotifierProvider(create: (_) => CFeed()),
        ChangeNotifierProvider(create: (_) => CExplore()),
        ChangeNotifierProvider(create: (_) => CMyTopic()),
        ChangeNotifierProvider(create: (_) => CAccount()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: AppColor.primary,
            colorScheme: const ColorScheme.light().copyWith(
              primary: AppColor.primary,
            )),
        routerConfig: AppRoute.routerConfig,
      ),
    );
  }
}
