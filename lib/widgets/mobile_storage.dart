import 'package:flutter/material.dart';
import 'package:sv_video_app/screens/internal_storage_file.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class StorageList extends StatelessWidget {
  const StorageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {},
          child: Column(
            children: const [
              FolderIcon(iconSize: CustomeSizes.folderLarge),
              VideoName(
                  input: 'SD Card',
                  textAlign: TextAlign.center,
                  width: CustomeSizes.folderLarge)
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InternalStorageFile(),
                ));
          },
          child: Column(
            children: const [
              FolderIcon(iconSize: CustomeSizes.folderLarge),
              VideoName(
                  input: 'Internal Storage',
                  textAlign: TextAlign.center,
                  width: CustomeSizes.folderLarge)
            ],
          ),
        ),
      ],
    );
  }
}
