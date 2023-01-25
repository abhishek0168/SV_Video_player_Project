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
          return InkWell(
            onTap: () {},
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Expanded(
                  child: FolderIcon(iconSize: CustomeSizes.folderMideum),
                ),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: VideoName(
                        input: "Name of the folderName",
                        textAlign: TextAlign.left,
                        width: 250,
                      ),
                    )),
              ],
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
