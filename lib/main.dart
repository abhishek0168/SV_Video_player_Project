import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:sv_video_app/screens/main_page.dart';
import 'package:sv_video_app/themes/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('video_storage');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SV Player',
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColor.bgColor,
      ),
      home: const MainPage(),
    );
  }
}
