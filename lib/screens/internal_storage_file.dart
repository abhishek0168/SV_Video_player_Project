import 'package:flutter/material.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class InternalStorageFile extends StatelessWidget {
  const InternalStorageFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        title: const Text('Internal Storage'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        itemBuilder: (context, index) {
          return const ListTile(
            leading: FolderIcon(iconSize: CustomeSizes.folderMideum),
            title: Text(
              'Folder Name',
              style: CustomeTextStyle.fileNameWhite,
            ),
            trailing: Icon(
              Icons.more_vert,
              color: AppColor.whiteColor,
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
