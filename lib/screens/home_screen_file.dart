import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
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
  void initState() {
    super.initState();
     VideoDatabaseFunction.changeFavList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        left: 25,
      ),
      children: const [
        PrimaryHeading(input: 'Favorite', textColor: AppColor.textColor),
        SizedBox(
          height: 140,
          child: FavoritesList(),
        ),
        PrimaryHeading(input: 'Recently played', textColor: AppColor.textColor),
        SizedBox(
          height: 140,
          child: RecentlyPlayed(),
        ),
        PrimaryHeading(input: 'Storage', textColor: AppColor.textColor),
        StorageList(),
      ],
    );
  }
}
