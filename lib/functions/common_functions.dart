import 'dart:developer';

import 'package:video_thumbnail/video_thumbnail.dart';

class Generator {
  static Future<List> getThumbnail(List demoVideo) async {
    List<String> videoThumb = [];
    for (var videofile in demoVideo) {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videofile.toString(),
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128,
        quality: 25,
      );

      videoThumb.add(uint8list.toString());
    }
    return videoThumb;
  }

  static List<String> getVideoName(dynamic videoList) {
    List<String> videoName = [];
    for (var fileDir in videoList) {
      var tempName = fileDir.toString().split('/');
      String fileName = tempName.last;
      videoName.add(fileName);
    }
    log(videoName.toString());
    return videoName;
  }
  
}
