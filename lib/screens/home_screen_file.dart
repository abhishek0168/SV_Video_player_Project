import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';
import 'package:sv_video_app/widgets/Favorites_list.dart';
import 'package:sv_video_app/widgets/mobile_storage.dart';
import 'package:sv_video_app/widgets/recently_played_list.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({super.key});

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        left: 25,
      ),
      children: [
        const PrimaryHeading(input: 'Favorite', textColor: AppColor.textColor),
        //ignore: sized_box_for_whitespace
        Container(
          // color: AppColor.secondBgColor,
          height: 140,
          child: const FavoritesList(),
        ),
        const PrimaryHeading(
            input: 'Recently played', textColor: AppColor.textColor),
        //ignore: sized_box_for_whitespace
        Container(
          // color: AppColor.secondBgColor,
          height: 140,
          child: const RecentlyPlayed(),
        ),
        const PrimaryHeading(input: 'Storage', textColor: AppColor.textColor),
        const StorageList(),
      ],
    );
  }
}
