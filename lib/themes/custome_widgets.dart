import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sv_video_app/icons/Folder_icon.dart';
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
}

class CustomeTextStyle {
  static const TextStyle fileNameWhite = TextStyle(
      color: AppColor.textColor, fontSize: 18, fontWeight: FontWeight.bold);
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
              'is empty',
              style: CustomeTextStyle.fileDuration,
            )
          ]),
    );
  }
}
