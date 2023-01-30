import 'dart:developer';

import 'package:video_thumbnail/video_thumbnail.dart';

class Generator {
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
