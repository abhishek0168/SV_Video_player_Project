import 'package:image/image.dart' as img;
import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sv_video_app/db/model/data_model.dart';
import 'package:flutter/widgets.dart';

ValueNotifier<List<VideoModel>> videoListNotifier = ValueNotifier([]);

class VideoDatabaseFunction {
  getAllVideos() async {
    final box = await Hive.openBox<VideoModel>('video_details');
    box.clear();

    // ---- Fetching all videos ---- //
    FetchAllVideos ob = FetchAllVideos();
    List videos = await ob.getAllVideos();

    for (var fileDir in videos) {
      // ---- storing video name ---- //
      String tempName = fileDir.toString();
      if (tempName.endsWith('/')) {
        tempName = tempName.substring(0, tempName.length - 1);
      }
      List<String> tempList = tempName.split('/');
      String fileName = tempList.last;

      // ---- storing video duration ---- //
      final videoInfo = await FlutterVideoInfo().getVideoInfo(fileDir);
      double millisec = videoInfo!.duration!;
      Duration videoDur = Duration(milliseconds: millisec.toInt());
      String formattedDuration =
          videoDur.toString().split('.').first.padLeft(8, "0");

      // ---- storing video thumbnail ---- //

      // File file = File(fileDir);
      // Uint8List bytes = await file.readAsBytes();

      // // Decode the image from the byte array
      // img.Image originalImage = img.decodeImage(bytes)!;

      // // Resize the image
      // img.Image thumbnail = img.copyResize(originalImage, width: 100);

      // // Encode the image to a new byte array
      // Uint8List thumbnailBytes = img.encodePng(thumbnail);

      // // Create a new image object with the thumbnail image data
      // Image thumbnailImage = Image.memory(thumbnailBytes);
      // log(thumbnailImage.toString());

      box.add(VideoModel(
        videoUrl: fileDir,
        videoName: fileName,
        videoDuration: formattedDuration,
      ));
    }

    videoListNotifier.value.addAll(box.values);
  }
}
