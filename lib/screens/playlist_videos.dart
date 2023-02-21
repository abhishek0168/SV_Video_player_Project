import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/playlist_function.dart';
import 'package:sv_video_app/icons/Folder_icon.dart';
import 'package:sv_video_app/screens/video_playing_screen.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class VideosInPlaylist extends StatelessWidget {
  const VideosInPlaylist(
      {super.key, required this.playlistName, required this.indexValue});
  final String playlistName;
  final int indexValue;

  @override
  Widget build(BuildContext context) {
    final videoDetails = playlistValue.value[indexValue].playlistItem;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: PrimaryHeading(
              input: playlistName, textColor: AppColor.primaryColor),
        ),
        body: videoDetails.isNotEmpty
            ? ValueListenableBuilder(
                valueListenable: playlistValue,
                builder: (context, playlistValue, _) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Videoplayer(
                                  videoUrl: videoDetails[index].videoUrl,
                                  index: index,
                                  dbData: videoDetails[index],
                                );
                              },
                            ));
                          },
                          child: ListTile(
                            leading: const Icon(
                              CustomeAppIcon.video,
                              color: AppColor.primaryColor,
                              size: CustomeSizes.iconSmall,
                            ),
                            title: VideoName(
                                input: videoDetails[index].videoName,
                                textAlign: TextAlign.left,
                                width: 200),
                            trailing: IconButton(
                                onPressed: () {
                                  PlaylistFunction().removeFromPlaylist(
                                    itemData: playlistValue[indexValue],
                                    videoUrl: videoDetails[index].videoUrl,
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColor.whiteColor,
                                )),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: videoDetails.length);
                },
              )
            : const EmptyMessage());
  }
}
