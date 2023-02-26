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
          return FileManager(
            emptyFolder: const EmptyMessage(),
            controller: controller,
            builder: (context, snapshot) {
              final List<FileSystemEntity> entities = snapshot;
              return ListView.builder(
                itemCount: storageList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // final bahu = storageList[index];
                  return InkWell(
                    onTap: () {
                      controller.openDirectory(entities[index]);
                      // Navigator.pop(context);
                      log(storageList.toString());
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return const InternalStorageFile();
                      //   },
                      // ),
                      // );
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
              );
            },
          );
        }
        return const SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            backgroundColor: AppColor.secondBgColor,
          ),
        );
      },
    );
  }
}
