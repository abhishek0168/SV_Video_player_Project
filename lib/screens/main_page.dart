import 'package:flutter/material.dart';
import 'package:sv_video_app/screens/home_screen_file.dart';
import 'package:sv_video_app/screens/playlist_screen_file.dart';
import 'package:sv_video_app/screens/video_screen_file.dart';
import 'package:sv_video_app/themes/app_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;
  final screens = [
    const VideoScreen(),
    const HomeScreeen(),
    const PlaylistScreen(),
  ];

  onTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        title: Image.asset('assets/images/logo-full.png', width: 140),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            onTab(index);
          },
          currentIndex: _currentIndex,
          backgroundColor: AppColor.primaryColor,
          iconSize: 30,
          unselectedItemColor: AppColor.whiteColor,
          selectedItemColor: AppColor.secondaryColor,
          selectedLabelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow_rounded),
              label: 'Video',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              label: 'File',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play_rounded),
              label: 'Playlist',
            ),
          ]),
    );
  }
}
