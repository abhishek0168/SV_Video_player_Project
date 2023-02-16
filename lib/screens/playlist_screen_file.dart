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
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
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

  moreDelete(BuildContext context, PlaylistModel deleteItem) {
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
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        PlaylistFunction().removePlaylist(itemData: deleteItem);
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
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
