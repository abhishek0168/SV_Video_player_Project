import 'dart:developer';

import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
import 'package:sv_video_app/functions/common_functions.dart';
import 'package:sv_video_app/screens/video_playing_screen.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  // ignore: must_call_super
  initState() {
    super.initState();
  }

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
            final data = videoDetails[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Videoplayer(
                      videoData: data.videoUrl,
                    );
                  },
                ));
              },
              child: VideoPreview(
                fileName: data.videoName,
              ),
            );
          },
          itemCount: videoDetails.length,
        );
      },
    );
  }
}
