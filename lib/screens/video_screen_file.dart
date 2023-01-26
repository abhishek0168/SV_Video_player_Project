import 'dart:developer';
import 'dart:html';

import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';
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
    getAllVideos();
  }

  List videos = [];
  List videoThumb = [];

  void getAllVideos() async {
    FetchAllVideos ob = FetchAllVideos();
    videos = await ob.getAllVideos();
    log(videos.toString());
    // videoThumb = await ThumbnailMaker.getThumbnail(videos);
    await createThumbnail(videoList: videos);
    setState(() {});
  }

  Future<void> createThumbnail({List? videoList}) async {
    try {
      for (var videofile in videoList!) {
        final file = await VideoThumbnail.thumbnailFile(
          video: videofile,
          imageFormat: ImageFormat.JPEG,
          maxWidth: 128,
        );
        videoThumb.add(file);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
                return Videoplayer(videoData: videos[index].toString());
              },
            ));
          },
          child: VideoPreview(
            fileName: 'Demo - ${index + 1}',
          ),
        );
      },
      itemCount: videos.length,
    );
  }
}
