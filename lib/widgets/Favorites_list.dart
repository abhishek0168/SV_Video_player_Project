import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
import 'package:sv_video_app/db/functions/db_function_fav.dart';
import 'package:sv_video_app/screens/video_playing_screen.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  void initState() {
    favListNotifier;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: favListNotifier,
        builder: (context, favList, child) {
          return ListView.separated(
            // reverse: true,
            shrinkWrap: true,
            padding: const EdgeInsets.only(right: 25),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Videoplayer(
                      videoData: favList[index].favouriteUrl,
                      index: index,
                    );
                  },
                ));
              },
              child: VideoPreview(
                fileName: 'demo',
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemCount: favList.length,
          );
        });
  }
}
