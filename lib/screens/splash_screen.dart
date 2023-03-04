import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
import 'package:sv_video_app/screens/main_page.dart';
import 'package:permission_handler/permission_handler.dart';
import '../db/functions/playlist_function.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MySplashScreen> {
  @override
  void initState() {
    // requestPermission();
    moveOn();
    super.initState();
  }

  void requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  void moveOn() async {
    await Future.delayed(const Duration(seconds: 2), () {
      VideoDatabaseFunction().getAllVideos();
      PlaylistFunction().getAllPlaylist();
      VideoDatabaseFunction().changeFavList();
    });

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const MainPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo-full.png',
                  scale: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
