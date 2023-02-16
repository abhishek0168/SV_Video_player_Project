import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sv_video_app/db/functions/db_function.dart';
import 'package:sv_video_app/db/model/data_model.dart';
import 'package:sv_video_app/db/model/playlist_model.dart';
import 'package:sv_video_app/icons/Folder_icon.dart';
import 'package:sv_video_app/screens/video_playing_screen.dart';
import 'package:sv_video_app/themes/app_colors.dart';

class PrimaryHeading extends StatelessWidget {
  final String input;
  final Color textColor;
  const PrimaryHeading(
      {super.key, required this.input, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        input,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}

class VideoName extends StatelessWidget {
  const VideoName({
    super.key,
    required this.input,
    required this.textAlign,
    required this.width,
  });

  final String input;
  final TextAlign textAlign;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        input,
        textAlign: textAlign,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColor.textColor,
        ),
      ),
    );
  }
}

class VideoPreview extends StatelessWidget {
  const VideoPreview(
      {super.key,
      required this.fileName,
      this.thumbnailURL,
      this.fileDuration,
      this.moreBottonFunction});
  final String fileName;
  final String? thumbnailURL;
  final String? fileDuration;
  final Function()? moreBottonFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
              width: 150,
              height: 100,
              color: AppColor.primaryColor,
              // child: thumbnailURL,
              child: Stack(
                alignment: AlignmentDirectional.center,
                fit: StackFit.expand,
                children: [
                  Container(
                    child: thumbnailURL != null
                        ? Image.file(
                            File(thumbnailURL.toString()),
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Icon(
                            CustomeAppIcon.video_1,
                            size: 40,
                            color: AppColor.secondaryColor,
                          )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: fileDuration != null
                          ? Text(
                              fileDuration.toString(),
                              style: CustomeTextStyle.fileDuration,
                            )
                          : const Text(
                              '00 :00',
                              style: CustomeTextStyle.fileDuration,
                            ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: moreBottonFunction,
                        icon: const Icon(
                          Icons.more_vert,
                          color: AppColor.whiteColor,
                          shadows: <Shadow>[
                            Shadow(color: Colors.black, blurRadius: 15.0)
                          ],
                          size: 20,
                        )),
                  )
                ],
              )),
        ),
        VideoName(
          input: fileName,
          textAlign: TextAlign.left,
          width: 150,
        ),
      ],
    );
  }
}

Icon folderIcon(double iconSize) {
  return Icon(
    Icons.folder,
    color: AppColor.primaryColor,
    size: iconSize,
  );
}

class FolderIcon extends StatelessWidget {
  const FolderIcon({super.key, required this.iconSize});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Icon(
      CustomeAppIcon.folder,
      color: AppColor.primaryColor,
      size: iconSize,
    );
  }
}

class CustomeSizes {
  static const double folderLarge = 120;
  static const double folderMideum = 70;
  static const double iconSmall = 50;
  static const double iconUltraSmall = 30;
}

class CustomeTextStyle {
  static const TextStyle fileNameWhite = TextStyle(
      color: AppColor.textColor, fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle buttonText = TextStyle(
      // color: AppColor.secondaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold);

  static const TextStyle fileDuration = TextStyle(
      color: AppColor.textColor, fontSize: 12, fontWeight: FontWeight.bold);
}

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Is Empty',
              style: CustomeTextStyle.fileDuration,
            )
          ]),
    );
  }
}

class PlaylistPreview extends StatelessWidget {
  const PlaylistPreview(
      {super.key, required this.playlistData, this.moreFunction});

  final PlaylistModel playlistData;
  final void Function()? moreFunction;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: AppColor.secondBgColor,
        child: Column(children: [
          Container(
            color: AppColor.secondaryColor,
            padding: const EdgeInsets.all(10),
            width: 150,
            height: 100,
            child: const Icon(
              CustomeAppIcon.video_1,
              size: 70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: VideoName(
                      input: playlistData.playlistName,
                      textAlign: TextAlign.left,
                      width: 150),
                ),
                InkWell(
                  onTap: moreFunction,
                  child: const Icon(
                    Icons.more_vert,
                    color: AppColor.whiteColor,
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class CustomeButtonStyle {
  static final ButtonStyle bgTextStyle = ElevatedButton.styleFrom(
    textStyle: CustomeTextStyle.buttonText,
    backgroundColor: AppColor.primaryColor,
    foregroundColor: AppColor.secondaryColor,
  );
}

Widget customIconMenu(IconData selectIcon) {
  return Icon(
    selectIcon,
    color: AppColor.whiteColor,
    size: CustomeSizes.iconUltraSmall,
  );
}

class CustomSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<VideoModel> matchQuery = [];
    for (var item in videoListNotifier.value) {
      if (item.videoName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return matchQuery.isNotEmpty
            ? InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Videoplayer(
                        videoUrl: result.videoUrl,
                        index: index,
                        dbData: result,
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
                      input: result.videoName,
                      textAlign: TextAlign.left,
                      width: 200),
                  subtitle: Text(
                    result.videoDuration,
                    style: const TextStyle(color: AppColor.secondaryColor),
                  ),
                ),
              )
            : const EmptyMessage();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<VideoModel> matchQuery = [];
    for (var item in videoListNotifier.value) {
      if (item.videoName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return matchQuery.isNotEmpty
            ? InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Videoplayer(
                        videoUrl: result.videoUrl,
                        index: index,
                        dbData: result,
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
                      input: result.videoName,
                      textAlign: TextAlign.left,
                      width: 200),
                ),
              )
            : const EmptyMessage();
      },
    );
  }
}
