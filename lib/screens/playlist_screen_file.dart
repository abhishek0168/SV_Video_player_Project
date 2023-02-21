import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/playlist_function.dart';
import 'package:sv_video_app/db/model/playlist_model.dart';
import 'package:sv_video_app/screens/playlist_videos.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  void initState() {
    super.initState();
    PlaylistFunction().getAllPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: playlistValue,
        builder: (context, playlist, _) {
          return playlist.isNotEmpty
              ? GridView.builder(
                  itemCount: playlist.length,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        log('Navigator pushed');
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return VideosInPlaylist(
                              playlistName: playlist[index].playlistName,
                              indexValue: index,
                            );
                          },
                        ));
                      },
                      child: PlaylistPreview(
                        playlistData: playlist[index],
                        moreFunction: () async {
                          await moreDelete(context, playlist[index]);
                        },
                      ),
                    );
                  },
                )
              : const EmptyMessage();
        },
      ),
    );
  }

  moreDelete(BuildContext context, PlaylistModel playlistItem) {
    TextEditingController controllerPlaylist = TextEditingController();
    controllerPlaylist.text = playlistItem.playlistName;
    final formKey = GlobalKey<FormState>();
    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            color: AppColor.secondBgColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            actionsPadding: const EdgeInsets.all(20),
                            actionsAlignment: MainAxisAlignment.end,
                            backgroundColor: AppColor.secondBgColor,
                            title: const PrimaryHeading(
                                input: 'Rename Playlist',
                                textColor: AppColor.primaryColor),
                            content: Form(
                              key: formKey,
                              child: TextFormField(
                                style:
                                    const TextStyle(color: AppColor.textColor),
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
                                controller: controllerPlaylist,
                                validator: (controllerPlaylist) {
                                  String tempName = playlistItem.playlistName;
                                  for (var item in playlistValue.value) {
                                    if (item.playlistName ==
                                            controllerPlaylist &&
                                        controllerPlaylist != tempName) {
                                      return 'This name already exists';
                                    }
                                  }
                                  if (controllerPlaylist == null ||
                                      controllerPlaylist.isEmpty) {
                                    return 'Please enter a name';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    PlaylistFunction().renamePlaylist(
                                        itemData: playlistItem,
                                        playlistRename:
                                            controllerPlaylist.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Name Changed'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                style: CustomeButtonStyle.bgTextStyle,
                                child: const Text('Submit'),
                              )
                            ],
                          ),
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.edit,
                            color: AppColor.whiteColor,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          PrimaryHeading(
                            input: 'Rename',
                            textColor: AppColor.textColor,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        PlaylistFunction()
                            .removePlaylist(itemData: playlistItem);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete,
                            color: AppColor.whiteColor,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          PrimaryHeading(
                            input: 'Delete',
                            textColor: AppColor.textColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
