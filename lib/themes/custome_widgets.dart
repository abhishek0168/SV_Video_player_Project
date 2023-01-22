import 'dart:io';

import 'package:flutter/material.dart';
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
  const VideoPreview({super.key, required this.fileName, this.thumbnailURL});
  final String fileName;
  final String? thumbnailURL;

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
            child: thumbnailURL != null
                ? Stack(
                    alignment: AlignmentDirectional.center,
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        File(thumbnailURL.toString()),
                        fit: BoxFit.cover,
                      ),
                      // Positioned(
                      //   child: Text('00:00'),
                      // )
                    ],
                  )
                : const Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ),
          ),
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
      Icons.folder,
      color: AppColor.primaryColor,
      size: iconSize,
    );
  }
}

class CustomeSizes {
  static const double folderLarge = 120;
}
