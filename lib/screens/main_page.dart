import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sv_video_app/screens/home_screen_file.dart';
import 'package:sv_video_app/screens/playlist_screen_file.dart';
import 'package:sv_video_app/screens/video_screen_file.dart';
import 'package:sv_video_app/text/texts.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

import '../db/functions/db_function.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColor.bgColor,
        title: Image.asset('assets/images/logo-full.png', width: 140),
        elevation: 0,
        automaticallyImplyLeading: true,
        // leading: Visibility(child: TextFormField()),
        actions: [
          Visibility(
            visible: _currentIndex == 0 ? true : false,
            child: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearch());
              },
              icon: const Icon(Icons.search),
            ),
          ),
          IconButton(onPressed: _openEndDrawer, icon: const Icon(Icons.dehaze))
        ],
      ),
      body: screens[_currentIndex],
      endDrawer: const Drawer(
        backgroundColor: AppColor.bgColor,
        child: DrawerView(),
      ),
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

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          padding: EdgeInsets.zero,
          child: Container(
            color: AppColor.secondaryColor,
            child: Center(
              child: Image.asset('assets/images/logo-full.png'),
            ),
          ),
        ),
        ListTile(
          leading: customIconMenu(Icons.library_books_rounded),
          title: const Text(
            'Terms and conditions',
            style: CustomeTextStyle.fileNameWhite,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return PopupDialogBox(popupContent: AppText.termsAndConditons);
              },
            );
          },
        ),
        ListTile(
          leading: customIconMenu(Icons.key),
          title: const Text(
            'privacy policy',
            style: CustomeTextStyle.fileNameWhite,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return PopupDialogBox(popupContent: AppText.privacyPolicy);
              },
            );
            // Navigator.pop(context);
          },
        ),
        ListTile(
          leading: customIconMenu(Icons.star),
          title: const Text(
            'Rate us',
            style: CustomeTextStyle.fileNameWhite,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: customIconMenu(Icons.person),
          title: const Text(
            'About us',
            style: CustomeTextStyle.fileNameWhite,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'version 1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.secondBgColor),
          ),
        )
      ],
    );
  }
}
