import 'dart:developer';

import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sv_video_app/db/model/data_model.dart';
import 'package:flutter/widgets.dart';

ValueNotifier<List<VideoModel>> videoListNotifier = ValueNotifier([]);
ValueNotifier<List<VideoModel>> favList = ValueNotifier([]);
ValueNotifier<List<VideoModel>> recentPlay = ValueNotifier([]);

class VideoDatabaseFunction {
  void fetchAllVideos() async {
    final box = Hive.box<VideoModel>('video_details');

    videoListNotifier.value.clear();
    // ---- Fetching all videos ---- //

    FetchAllVideos ob = FetchAllVideos();
    List videos = await ob.getAllVideos();

    var flag = false;
    for (var fileDir in videos) {
      log('sorting video');
      for (var item in box.values) {
        if (fileDir == item.videoUrl) {
          flag = true;
          log('same video');
          break;
        }
      }

      if (!flag) {
        // ---- storing video name ---- //

        String tempName = fileDir.toString();
        if (tempName.endsWith('/')) {
          tempName = tempName.substring(0, tempName.length - 1);
        }

        List<String> tempList = tempName.split('/');
        String fileName = tempList.last;
        fileName =
            fileName.replaceFirst(fileName[0], fileName[0].toUpperCase());

        // ---- storing video duration ---- //

        final videoInfo = await FlutterVideoInfo().getVideoInfo(fileDir);
        double millisec = videoInfo!.duration!;
        Duration videoDur = Duration(milliseconds: millisec.toInt());
        String formattedDuration =
            videoDur.toString().split('.').first.padLeft(8, "0");
        log('adding video');
        var val = await box.add(VideoModel(
            videoUrl: fileDir,
            videoName: fileName,
            videoDuration: formattedDuration,
            videoFavourite: false));

        var data = box.get(val);

        await box.put(
            val,
            VideoModel(
                videoUrl: data!.videoUrl,
                videoName: data.videoName,
                videoDuration: data.videoDuration,
                id: val,
                videoFavourite: data.videoFavourite));
      }
      flag = false;
    }

    log(box.values.length.toString());
    for (var item in box.values) {
      log('finding duplicate');
      if (!videos.contains(item.videoUrl)) {
        box.delete(item.id!);
        log('duplicate removed');
      }
    }

    log(box.values.length.toString());
    videoListNotifier.value.addAll(box.values);
  }

  // ---- Changing Favourite List ---- //

  void changeFavorites(VideoModel videoData) async {
    final box = Hive.box<VideoModel>('video_details');
    videoListNotifier.value.clear();

    await box.put(
      videoData.id,
      VideoModel(
        id: videoData.id,
        videoUrl: videoData.videoUrl,
        videoName: videoData.videoName,
        videoDuration: videoData.videoDuration,
        videoFavourite: !videoData.videoFavourite,
      ),
    );

    videoListNotifier.value.addAll(box.values);
    log(videoListNotifier.value.length.toString());
  }

  static void changeFavList() {
    favList.value.clear();
    for (var item in videoListNotifier.value) {
      if (item.videoFavourite == true) {
        favList.value.add(item);
        log('video added to favList');
      } else {
        if (favList.value.contains(item)) {
          favList.value.remove(item);
          log('video removed from favList');
        }
      }
    }

   
  }

  static void recentlyPlay(VideoModel videoData) async {
    recentPlay.value.clear();
    log(recentPlay.value.toString());
    final box = Hive.box<VideoModel>('video_recently');
    final boxToList = box.values.toList();

    boxToList.removeWhere(
      (element) => element.id == videoData.id,
    );
    await box.clear();

    boxToList.insert(0, videoData);

    await box.addAll(boxToList);

    log(box.values.toString());

    recentPlay.value.addAll(box.values);
    log(recentPlay.value.toString());
  }
}
