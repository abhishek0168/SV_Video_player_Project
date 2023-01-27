import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sv_video_app/db/model/data_model.dart';

ValueNotifier<List<VideoModel>> videoListNotifier = ValueNotifier([]);

class VideoDatabaseFunction {
  getAllVideos() async {
    final box = await Hive.openBox<VideoModel>('video_details');
    FetchAllVideos ob = FetchAllVideos();
    List videos = await ob.getAllVideos();

    List<VideoModel> videoData = [];
    for (var fileDir in videos) {
      var tempName = fileDir.toString().split('/');
      String fileName = tempName.last;
      box.add(VideoModel(
          videoUrl: fileDir, videoName: fileName, videoDuration: ''));
    }

    videoListNotifier.value.clear();

    videoListNotifier.value.addAll(box.values);
  }
}
