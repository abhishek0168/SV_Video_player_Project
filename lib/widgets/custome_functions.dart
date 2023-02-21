import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
import 'package:sv_video_app/db/functions/playlist_function.dart';
import 'package:sv_video_app/db/model/data_model.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class CustomeFunctions {
  static void moreFunction(VideoModel item, BuildContext context) {
    const String addFav = 'Add to favorite';
    const String removeFav = 'Remove from favorite';
    const String addPlaylist = 'Add to Playlist';
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
            mainAxisSize: MainAxisSize.min,
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
              // const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  morePlaylistFunction(item, context);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.playlist_add,
                      color: AppColor.whiteColor,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    PrimaryHeading(
                      input: addPlaylist,
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

    VideoDatabaseFunction().changeFavList();
  }

  static void morePlaylistFunction(VideoModel item, BuildContext context) {
    TextEditingController playlistNameController = TextEditingController();

    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        log(MediaQuery.of(context).size.height.toString() + 'is the height');
        return Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Container(
                color: AppColor.secondBgColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 7,
                          child: TextFormField(
                            controller: playlistNameController,
                            validator: (playlistNameController) {
                              for (var item in playlistValue.value) {
                                if (playlistNameController ==
                                    item.playlistName) {
                                  return 'This name already exists';
                                }
                              }
                              if (playlistNameController == null ||
                                  playlistNameController.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                            style: const TextStyle(color: AppColor.textColor),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                PlaylistFunction().createPlaylist(
                                    itemData: item,
                                    playlistName: playlistNameController.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Creating playlist')),
                                );
                                Navigator.pop(context);
                              }
                            },
                            style: CustomeButtonStyle.bgTextStyle,
                            child: const Text('Create'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: null,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            VideoName(
                                input: playlistValue.value[index].playlistName,
                                textAlign: TextAlign.left,
                                width: 200),
                            ElevatedButton(
                              onPressed: () {
                                PlaylistFunction().addToPlaylist(
                                    context: context,
                                    itemData: item,
                                    playlistName: playlistValue
                                        .value[index].playlistName);

                                Navigator.pop(context);
                              },
                              style: CustomeButtonStyle.bgTextStyle,
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                        itemCount: playlistValue.value.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
