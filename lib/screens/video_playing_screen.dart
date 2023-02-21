import 'dart:io';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
import 'package:video_player/video_player.dart';

import '../db/model/data_model.dart';

class Video extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool loop;
  final bool autoplay;
  final double aspectRatio;

  const Video({
    super.key,
    required this.videoPlayerController,
    required this.loop,
    required this.autoplay,
    required this.aspectRatio,
  });

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      looping: widget.loop,
      autoPlay: widget.autoplay,
      aspectRatio: widget.aspectRatio,
      // customControls: CustomControls(chewieController: _chewieController),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}

class Videoplayer extends StatefulWidget {
  const Videoplayer({
    super.key,
    required this.videoUrl,
    required this.index,
    this.dbData,
  });

  final String videoUrl;
  final int index;
  final VideoModel? dbData;
  @override
  State<Videoplayer> createState() => _VideoplayerState();
}

class _VideoplayerState extends State<Videoplayer> {
  @override
  void initState() {
    super.initState();
    // VideoDatabaseFunction.recentlyPlay(widget.dbData!);
    // addingToRecent();
    VideoDatabaseFunction.addToRecently(widget.videoUrl);
    recentPlay.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.videoUrl);
    return Scaffold(
      body: Stack(
        children: [
          Transform.scale(
            scale: VideoPlayerController.file(File(widget.videoUrl))
                .value
                .aspectRatio,
            child: Video(
              videoPlayerController:
                  VideoPlayerController.file(File(widget.videoUrl)),
              loop: false,
              autoplay: true,
              aspectRatio: VideoPlayerController.file(File(widget.videoUrl))
                  .value
                  .aspectRatio,
            ),
          ),
          // Center(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       InkWell(
          //         onTap: () {},
          //         child: const Icon(
          //           Icons.skip_previous,
          //           size: 40,
          //           color: AppColor.whiteColor,
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 50,
          //       ),
          //       InkWell(
          //         onTap: () {},
          //         child: const Icon(
          //           Icons.skip_next,
          //           size: 40,
          //           color: AppColor.whiteColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
