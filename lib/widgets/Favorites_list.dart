import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
import 'package:sv_video_app/screens/video_playing_screen.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';
import 'package:sv_video_app/widgets/custome_functions.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: favList,
      builder: (context, favList, _) {
        return favList.isNotEmpty
            ? ListView.separated(
                // reverse: true,
                shrinkWrap: true,
                padding: const EdgeInsets.only(right: 25),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Videoplayer(
                          videoData: favList[index].videoUrl,
                          index: index,
                        );
                      },
                    ));
                  },
                  child: VideoPreview(
                      fileName: favList[index].videoName,
                      fileDuration: favList[index].videoDuration,
                      moreBottonFunction: () {
                        setState(() {
                          CustomeFunctions.moreFunction(
                              favList[index], context);
                        });
                      }),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                itemCount: favList.length,
              )
            : const EmptyMessage();
      },
    );
  }
}
