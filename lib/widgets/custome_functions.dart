import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
import 'package:sv_video_app/db/model/data_model.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class CustomeFunctions {
  static void moreFunction(VideoModel item, BuildContext context) {
    const String addFav = 'Add to favorite';
    const String removeFav = 'Remove from favorite';
    bool favList = item.videoFavourite;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: AppColor.secondBgColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 30,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  VideoDatabaseFunction().changeFavorites(item);
                  log(item.videoFavourite.toString());
                  log(item.toString());

                  
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      favList ? Icons.favorite : Icons.favorite_border,
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    PrimaryHeading(
                      input: favList ? removeFav : addFav,
                      textColor: AppColor.textColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    VideoDatabaseFunction.changeFavList();
  }
}
