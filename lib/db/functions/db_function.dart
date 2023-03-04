import 'package:export_video_frame/export_video_frame.dart';
import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sv_video_app/db/model/data_model.dart';

ValueNotifier<List<VideoModel>> videoListNotifier = ValueNotifier([]);
ValueNotifier<List<VideoModel>> favList = ValueNotifier([]);
ValueNotifier<List<VideoModel>> recentPlay = ValueNotifier([]);

class VideoDatabaseFunction {
  Future<void> getAllVideos() async {
// ---- video database ---- //

    final box = Hive.box<VideoModel>('video_details');
    videoListNotifier.value.clear();
    videoListNotifier.value.addAll(box.values);

    // ---- recently played database ---- //

    final recent = Hive.box<VideoModel>('video_recently');
    recentPlay.value.clear();
    recentPlay.value.addAll(recent.values);
    fetchAllVideos();

    changeFavList();
  }

  Future<void> fetchAllVideos() async {
    final box = Hive.box<VideoModel>('video_details');
    videoListNotifier.value.clear();

// ---- Fetching all videos ---- //

    FetchAllVideos ob = FetchAllVideos();
    List videos = await ob.getAllVideos();

    var flag = false;
    for (var fileDir in videos) {
      for (var item in box.values) {
        if (fileDir == item.videoUrl) {
          flag = true;
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
            videoDur.toString().split('.').first.padLeft(8, '0');

        // ---- thumbnail ---- //
        var images = await ExportVideoFrame.exportImage(fileDir, 1, 1);
        String tempThump = images[0].toString();
        tempThump = tempThump.substring(7, tempThump.length - 1);

        var val = await box.add(
          VideoModel(
            videoUrl: fileDir,
            videoName: fileName,
            videoDuration: formattedDuration,
            videoFavourite: false,
            videoThumbnail: tempThump,
          ),
        );

        var data = box.get(val);

        await box.put(
          val,
          VideoModel(
            videoUrl: data!.videoUrl,
            videoName: data.videoName,
            videoDuration: data.videoDuration,
            id: val,
            videoFavourite: data.videoFavourite,
            videoThumbnail: data.videoThumbnail,
          ),
        );
      }
      flag = false;
    }

    for (var item in box.values) {
      if (!videos.contains(item.videoUrl)) {
        box.delete(item.id!);
      }
    }

    videoListNotifier.value.addAll(box.values);
    videoListNotifier.notifyListeners();
    videoListNotifier.value.sort(
      (a, b) {
        return a.videoName.compareTo(b.videoName);
      },
    );
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
        videoThumbnail: videoData.videoThumbnail,
      ),
    );

    videoListNotifier.value.addAll(box.values);
    videoListNotifier.value.sort(
      (a, b) {
        return a.videoName.compareTo(b.videoName);
      },
    );
    videoListNotifier.notifyListeners();
    changeFavList();
  }

  void changeFavList() {
    favList.value.clear();
    for (var item in videoListNotifier.value) {
      if (item.videoFavourite == true) {
        favList.value.add(item);
      } else {
        if (favList.value.contains(item)) {
          favList.value.remove(item);
        }
      }
      favList.notifyListeners();
    }
  }

  static void addToRecently(String videoUrl) {
    final box = Hive.box<VideoModel>('video_details');
    VideoModel? tempItem;
    bool status = false;
    for (var element in box.values) {
      String tempLink = element.videoUrl;
      if (tempLink.endsWith('/')) {
        tempLink = tempLink.substring(0, tempLink.length - 1);
      }
      if (videoUrl.endsWith('/')) {
        videoUrl = videoUrl.substring(0, videoUrl.length - 1);
      }
      if (videoUrl == tempLink) {
        tempItem = element;
        status = true;
        break;
      }
    }
    if (status) {
      recentlyPlay(tempItem!);
    }
  }

  static void recentlyPlay(VideoModel videoData) async {
    recentPlay.value.clear();
    final box = Hive.box<VideoModel>('video_recently');
    final boxToList = box.values.toList();

    boxToList.removeWhere(
      (element) => element.id == videoData.id,
    );
    await box.clear();

    boxToList.insert(0, videoData);

    await box.addAll(boxToList);

    recentPlay.value.addAll(box.values);
    recentPlay.notifyListeners();
  }
}
