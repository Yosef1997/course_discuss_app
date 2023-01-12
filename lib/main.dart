import 'package:course_discuss_app/config/app_color.dart';
import 'package:course_discuss_app/config/app_route.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light().copyWith(
            primary: AppColor.primary,
          )),
      routerConfig: AppRoute.routerConfig,
    );
  }
}
