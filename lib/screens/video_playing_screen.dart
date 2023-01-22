import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
        aspectRatio: widget.aspectRatio);
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}

class Videoplayer extends StatefulWidget {
  const Videoplayer({super.key, required this.videoData});

  final String videoData;

  @override
  State<Videoplayer> createState() => _VideoplayerState();
}

class _VideoplayerState extends State<Videoplayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Video(
        videoPlayerController: VideoPlayerController.asset(widget.videoData),
        loop: true,
        autoplay: true,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
