import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sv_video_app/db/model/favourite_model.dart';

ValueNotifier<List<FavouriteModel>> favListNotifier = ValueNotifier([]);

class FavouriteList {
  void changeFavourite({required String videoUrl}) async {
    favListNotifier.value.clear();
    final box = await Hive.openBox<FavouriteModel>('favourite_list');
    log('On function 1');

    bool found = false;
    for (var element in box.values) {
      if (element.favouriteUrl == videoUrl) {
        box.delete(element.key);
        log('video deleted');
        found = true;
        break;
      }
    }
    if (!found) {
      final val = await box.add(FavouriteModel(favouriteUrl: videoUrl));
      final data = box.get(val);
      await box.put(
          val, FavouriteModel(favouriteUrl: data!.favouriteUrl, key: val));
      log('video added');
    }

    log('box values: ${box.values}');

    favListNotifier.value.addAll(box.values);
    log(favListNotifier.value.toString());
  }
}
