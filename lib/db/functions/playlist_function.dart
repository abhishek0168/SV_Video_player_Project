import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sv_video_app/db/model/data_model.dart';
import 'package:sv_video_app/db/model/playlist_model.dart';

ValueNotifier<List<PlaylistModel>> playlistValue = ValueNotifier([]);

class PlaylistFunction {
  // ---- Creating playlist ---- //

  void createPlaylist(
      {required VideoModel itemData, required String playlistName}) async {
    final box = Hive.box<PlaylistModel>('playlist');
    playlistValue.value.clear();
    List<VideoModel> tempList = [];
    log('Adding to the playlist...');
    tempList.add(VideoModel(
        videoUrl: itemData.videoUrl,
        videoName: itemData.videoName,
        videoDuration: itemData.videoDuration,
        videoFavourite: itemData.videoFavourite));

    final listId = await box.add(
      PlaylistModel(
        playlistItem: tempList,
        playlistName: playlistName,
      ),
    );

    final data = box.get(listId);

    await box.put(
      listId,
      PlaylistModel(
          playlistItem: data!.playlistItem,
          playlistName: data.playlistName,
          id: listId),
    );

    playlistValue.value.addAll(box.values);
    playlistValue.notifyListeners();
  }

  // ---- video adding to the playlist ---- //

  void addToPlaylist(
      {required VideoModel itemData,
      required String playlistName,
      required BuildContext context}) async {
    final box = Hive.box<PlaylistModel>('playlist');
    playlistValue.value.clear();
    bool flag = false;
    PlaylistModel? dbitem;
    List<VideoModel>? dbList;

    for (var dbItem in box.values) {
      if (dbItem.playlistName == playlistName) {
        flag = true;
        dbitem = dbItem;
        break;
      }
    }

    if (flag) {
      dbList = dbitem!.playlistItem.toList();

      bool status = false;
      for (var item in dbList) {
        if (item.videoUrl == itemData.videoUrl) {
          status = true;

          // ---- Error message ---- //
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Video already in playlist')),
          );
          break;
        }
      }

      // dbitem.playlistItem.clear();

      if (!status) {
        dbitem.playlistItem.clear();
        dbList.insert(0, itemData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video added to the playlist')),
        );

        await box.put(
          dbitem.id,
          PlaylistModel(
            playlistItem: dbList,
            playlistName: playlistName,
          ),
        );
      }
    }

    playlistValue.value.addAll(box.values);
    playlistValue.notifyListeners();
  }

  // ---- removing video from playlist ---- //

  void removeFromPlaylist(
      {required VideoModel itemData, required String playlistName}) async {
    final box = Hive.box<PlaylistModel>('playlist');
    playlistValue.value.clear();
    bool flag = false;
    PlaylistModel? dbitem;
    List<VideoModel>? dbList;

    for (var dbItem in box.values) {
      if (dbItem.playlistName == playlistName) {
        flag = true;
        dbitem = dbItem;
        break;
      }
    }

    if (flag) {
      dbList = dbitem!.playlistItem.toList();
      dbitem.playlistItem.clear();

      dbList.removeWhere((element) => element.id == itemData.id);
      await box.put(
        dbitem.id,
        PlaylistModel(
          playlistItem: dbList,
          playlistName: playlistName,
        ),
      );
    } else {
      // ---- Error message ---- //
    }

    playlistValue.value.addAll(box.values);
    playlistValue.notifyListeners();
  }

  // ---- remove playlist ---- //

  void removePlaylist({required String playlistName}) async {
    final box = Hive.box<PlaylistModel>('playlist');
    playlistValue.value.clear();
    final tempList = box.values.toList();
    box.clear();
    log(playlistName);
    tempList.removeWhere((element) {
      return element.playlistName == playlistName;
    });

    box.addAll(tempList);

    playlistValue.value.addAll(box.values);
    playlistValue.notifyListeners();
  }
}
