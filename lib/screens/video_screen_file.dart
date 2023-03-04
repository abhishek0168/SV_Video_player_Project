import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
import 'package:sv_video_app/screens/video_playing_screen.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';
import 'package:sv_video_app/widgets/custome_functions.dart';
import 'package:video_player/video_player.dart';

List<VideoPlayerController> videoControllers = [];

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: videoListNotifier,
      builder: (context, videoDetails, _) {
        return videoDetails.isEmpty
            ? const EmptyMessage()
            : GridView.builder(
                itemCount: videoDetails.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                            videoUrl: videoDetails[index].videoUrl,
                            index: index,
                            dbData: videoDetails[index],
                          );
                        },
                      ));
                    },
                    child: VideoPreview(
                      fileName: videoDetails[index].videoName,
                      fileDuration: videoDetails[index].videoDuration,
                      moreBottonFunction: () {
                        CustomeFunctions.moreFunction(
                            videoDetails[index], context);
                      },
                      thumbnailURL: videoDetails[index].videoThumbnail,
                    ),
                  );
                },
              );
      },
    );
  }
}
