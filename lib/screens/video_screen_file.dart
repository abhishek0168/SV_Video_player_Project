import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
import 'package:sv_video_app/db/functions/db_function_fav.dart';
import 'package:sv_video_app/screens/video_playing_screen.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';
import 'package:sv_video_app/widgets/Favorites_list.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: videoListNotifier,
      builder: (context, videoDetails, _) {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            mainAxisSpacing: 0,
            crossAxisSpacing: 30,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Videoplayer(
                      videoData: videoDetails[index].videoUrl,
                      index: index,
                    );
                  },
                ));
              },
              child: VideoPreview(
                  fileName: videoDetails[index].videoName,
                  fileDuration: videoDetails[index].videoDuration,
                  // thumbnailURL: videoDetails[index].videoUrl,
                  moreBottonFunction: () {
                    moreFunction(videoDetails[index].videoUrl);
                  }),
            );
          },
          itemCount: videoDetails.length,
        );
      },
    );
  }

  void moreFunction(String videoUrl) {
    const String _addFav = 'Add to favorite';
    const String _removeFav = 'Remove from favorite';
    bool? favList;
    bool found = false;
    for (var element in favListNotifier.value) {
      log('moreFunction');
      if (element.favouriteUrl == videoUrl) {
        favList = true;
        log('favList is true');
        found = true;
        break;
        
      }
    }
    if (!found) {
      favList = false;
      log('favList is false');
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: AppColor.secondBgColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 30,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  FavouriteList().changeFavourite(videoUrl: videoUrl);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      favList! ? Icons.favorite : Icons.favorite_border,
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    PrimaryHeading(
                      input: favList ? _removeFav : _addFav,
                      textColor: AppColor.textColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
