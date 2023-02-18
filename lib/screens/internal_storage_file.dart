import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sv_video_app/icons/Folder_icon.dart';
import 'package:sv_video_app/screens/video_playing_screen.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:file_manager/file_manager.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class InternalStorageFile extends StatefulWidget {
  const InternalStorageFile({super.key});

  @override
  State<InternalStorageFile> createState() => _InternalStorageFileState();
}

class _InternalStorageFileState extends State<InternalStorageFile> {
  FileManagerController controller = FileManagerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await controller.goToParentDirectory();
          },
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: AppColor.bgColor,
        title: ValueListenableBuilder(
          valueListenable: controller.titleNotifier,
          builder: (context, title, _) => Text(title),
        ),
      ),
      body: FileManager(
        emptyFolder: const EmptyMessage(),
        controller: controller,
        builder: (context, snapshot) {
          final List<FileSystemEntity> entities = snapshot;

          return ListView.separated(
            itemCount: entities.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemBuilder: (context, index) {
              return ListTile(
                horizontalTitleGap: 20,
                leading: SizedBox(
                  width: 80,
                  child: FileManager.isFile(entities[index])
                      ? const Icon(
                          CustomeAppIcon.video,
                          color: AppColor.primaryColor,
                          size: CustomeSizes.iconSmall,
                        )
                      : const FolderIcon(iconSize: CustomeSizes.folderMideum),
                ),
                title: Text(
                  FileManager.basename(entities[index]),
                  style: CustomeTextStyle.fileNameWhite,
                ),
                onTap: () {
                  if (FileManager.isDirectory(entities[index])) {
                    controller.openDirectory(entities[index]);
                    // Navigator.push( context, MaterialPageRoute( builder: (context) {}));
                    // open directory
                  } else {
                    log(entities[index].toString());
                    String item = entities[index]
                        .toString()
                        .substring(7, entities[index].toString().length - 1);
                    log(item);
                    if (item.startsWith('/')) {
                      item = item.substring(1, item.length);
                    }
                    log(item);
                    if (item.endsWith('mp4')) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Videoplayer(videoUrl: item, index: index);
                        },
                      ));
                    }
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
