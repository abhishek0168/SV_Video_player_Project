import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sv_video_app/db/model/data_model.dart';
import 'package:sv_video_app/db/model/playlist_model.dart';

import 'package:sv_video_app/screens/splash_screen.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error\n${details.exception}',
        style: CustomeTextStyle.errorStyle,
      ),
    );
  };

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(VideoModelAdapter().typeId)) {
    Hive.registerAdapter(VideoModelAdapter());
  }

  if (!Hive.isAdapterRegistered(PlaylistModelAdapter().typeId)) {
    Hive.registerAdapter(PlaylistModelAdapter());
  }

  await Hive.openBox<VideoModel>('video_details');
  await Hive.openBox<VideoModel>('video_recently');
  await Hive.openBox<PlaylistModel>('playlist');

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
      home: const MySplashScreen(),
    );
  }
}
