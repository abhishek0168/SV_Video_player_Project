import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sv_video_app/db/model/data_model.dart';
import 'package:sv_video_app/db/model/playlist_model.dart';

ValueNotifier<List<PlaylistModel>> playlistValue = ValueNotifier([]);

class PlaylistFunction {
  // ---- Creating playlist ---- //\

  void getAllPlaylist() {
    final box = Hive.box<PlaylistModel>('playlist');
    log('clearing playlist');
    playlistValue.value.clear();
    log('Adding playlist');

    playlistValue.value.addAll(box.values);
  }

  void createPlaylist(
      {required VideoModel itemData, required String playlistName}) async {
    final box = Hive.box<PlaylistModel>('playlist');
    playlistValue.value.clear();
    List<VideoModel> tempList = [];
    log('Adding to the playlist...');
    tempList.add(
      VideoModel(
        videoUrl: itemData.videoUrl,
        videoName: itemData.videoName,
        videoDuration: itemData.videoDuration,
        videoFavourite: itemData.videoFavourite,
      ),
    );

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
        id: listId,
      ),
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
    late PlaylistModel dbitem;
    List<VideoModel>? dbList;

    for (var dbItem in box.values) {
      if (dbItem.playlistName == playlistName) {
        flag = true;
        dbitem = dbItem;
        log('list name ${dbitem.playlistName} and and ${dbitem.id}');
        break;
      }
    }

    if (flag) {
      dbList = dbitem.playlistItem.toList();

      bool status = false;
      for (var item in dbList) {
        if (item.videoUrl == itemData.videoUrl) {
          status = true;

          // ---- Error message ---- //
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Video already in the playlist')),
          );
          break;
        }
      }

      if (!status) {
        dbitem.playlistItem.clear();
        dbList.add(
          VideoModel(
            videoUrl: itemData.videoUrl,
            videoName: itemData.videoName,
            videoDuration: itemData.videoDuration,
            videoFavourite: itemData.videoFavourite,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video added to the playlist')),
        );
        log(dbitem.id.runtimeType.toString()); // second time id become null
        await box.put(
          dbitem.id,
          PlaylistModel(
              playlistItem: dbList,
              playlistName: dbitem.playlistName,
              id: dbitem.id),
        );
      }
    }

    playlistValue.value.addAll(box.values);
    playlistValue.notifyListeners();
  }

  // ---- removing video from playlist ---- //

  void removeFromPlaylist(
      {required PlaylistModel itemData, required String videoUrl}) async {
    final box = Hive.box<PlaylistModel>('playlist');
    log('remove index $videoUrl');
    playlistValue.value.clear();
    List<VideoModel>? tempList;

    // tempList.removeWhere((element) => element.videoUrl.contains(videoUrl));
    for (var element in itemData.playlistItem) {
      if (element.videoUrl == videoUrl) {
        itemData.playlistItem.remove(element);
        tempList = itemData.playlistItem;
        break;
      }
    }

    box.put(
      itemData.id,
      PlaylistModel(
        playlistItem: tempList!,
        playlistName: itemData.playlistName,
        id: itemData.id,
      ),
    );

    playlistValue.value.addAll(box.values);
    playlistValue.notifyListeners();
  }

  // ---- remove playlist ---- //

  void removePlaylist({required PlaylistModel itemData}) async {
    final box = Hive.box<PlaylistModel>('playlist');
    playlistValue.value.clear();
    log(itemData.id.toString());
    box.delete(itemData.id);

    playlistValue.value.addAll(box.values);
    playlistValue.notifyListeners();
  }

  void renamePlaylist(
      {required PlaylistModel itemData, required String playlistRename}) {
    final box = Hive.box<PlaylistModel>('playlist');
    playlistValue.value.clear();
    log(itemData.id.toString());
    log(itemData.playlistName.toString());
    box.put(
      itemData.id,
      PlaylistModel(
        id: itemData.id,
        playlistItem: itemData.playlistItem,
        playlistName: playlistRename,
      ),
    );

    playlistValue.value.addAll(box.values);
    playlistValue.notifyListeners();
  }
}
