import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
import 'package:sv_video_app/main.dart';
import 'package:sv_video_app/screens/video_playing_screen.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: recentPlay,
        builder: (context, videoDetails, _) => recentPlay.value.isNotEmpty
            ? ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.only(right: 25),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Videoplayer(
                            dbData: videoDetails[index],
                            videoUrl: videoDetails[index].videoUrl,
                            index: index,
                          );
                        },
                      ));
                    },
                    child: VideoPreview(
                      fileName: videoDetails[index].videoName,
                      fileDuration: videoDetails[index].videoDuration,
                      thumbnailURL: videoDetails[index].videoThumbnail,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 20,
                ),
                itemCount: videoDetails.length <= 5 ? videoDetails.length : 5,
              )
            : const EmptyMessage());
  }
}
