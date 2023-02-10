import 'dart:developer';
import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:sv_video_app/screens/internal_storage_file.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class StorageList extends StatelessWidget {
  StorageList({super.key});

  final FileManagerController controller = FileManagerController();

  List<String> folderName = ['Internal Storage', 'SD Card'];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Directory>>(
      future: FileManager.getStorageList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<FileSystemEntity> storageList = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  controller.openDirectory(storageList[index]);
                  // Navigator.pop(context);
                  log(storageList.toString());
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return;
                  //   },
                  // ));
                },
                child: Column(
                  children: [
                    const FolderIcon(iconSize: CustomeSizes.folderLarge),
                    VideoName(
                      input: folderName[index],
                      textAlign: TextAlign.center,
                      width: CustomeSizes.folderLarge,
                    ),
                  ],
                ),
              );
            },
            itemCount: storageList.length,
          );
        }
        return const CircularProgressIndicator(
          backgroundColor: AppColor.secondBgColor,
        );
      },
    );
  }
}
