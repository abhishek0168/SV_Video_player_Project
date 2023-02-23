import 'dart:developer';
import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:thumbnailer/thumbnailer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sv_video_app/db/model/data_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

ValueNotifier<List<VideoModel>> videoListNotifier = ValueNotifier([]);
ValueNotifier<List<VideoModel>> favList = ValueNotifier([]);
ValueNotifier<List<VideoModel>> recentPlay = ValueNotifier([]);

class VideoDatabaseFunction {
  Future<void> getAllVideos() async {
// ---- video database ---- //

    final box = Hive.box<VideoModel>('video_details');
    videoListNotifier.value.clear();
    videoListNotifier.value.addAll(box.values);
    log(videoListNotifier.value.length.toString());

    // ---- recently played database ---- //

    final recent = Hive.box<VideoModel>('video_recently');
    recentPlay.value.clear();
    log('recent clearing');
    recentPlay.value.addAll(recent.values);
    await fetchAllVideos();

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

// ---- thumbnail ----//

        log('adding video');
        var val = await box.add(
          VideoModel(
            videoUrl: fileDir,
            videoName: fileName,
            videoDuration: formattedDuration,
            videoFavourite: false,
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
          ),
        );

        generateThumbnail(data.videoUrl);
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
    videoListNotifier.notifyListeners();
    videoListNotifier.value.sort(
      (a, b) {
        return a.videoName.compareTo(b.videoName);
      },
    );
  }

  Future<void> generateThumbnail(String videoUrl) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
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
      ),
    );

    videoListNotifier.value.addAll(box.values);
    log(videoListNotifier.value.length.toString());
    videoListNotifier.notifyListeners();
    changeFavList();
  }

  void changeFavList() {
    favList.value.clear();
    log('change favlist calling ');
    log(videoListNotifier.value.length.toString());
    for (var item in videoListNotifier.value) {
      log('favlist loop');
      if (item.videoFavourite == true) {
        favList.value.add(item);

        log('video added to favList');
      } else {
        if (favList.value.contains(item)) {
          favList.value.remove(item);

          log('video removed from favList');
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
        log('add to recent if');
        tempItem = element;
        status = true;
        break;
      }
    }
    if (status) {
      recentlyPlay(tempItem!);
    } else {
      log('add to recent not working');
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
    recentPlay.notifyListeners();
  }
}
