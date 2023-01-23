import 'package:flutter/material.dart';
import 'package:sv_video_app/screens/video_playing_screen.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  List<String> demoVideo = [
    'assets/demo_videos/demo-1.mp4',
    'assets/demo_videos/demo-2.mp4',
    'assets/demo_videos/demo-3.mp4',
    'assets/demo_videos/demo-4.mp4',
    'assets/demo_videos/demo-5.mp4',
  ];
  List<String> demoName = [
    'demo-1',
    'demo-2',
    'demo-3',
    'demo-4',
    'demo-5',
  ];

  @override
  void initState() {
    super.initState();
    // getThumbnail();
  }

  // void getThumbnail() async {
  //   for (var index in demoVideo) {
  //     final byteData = await rootBundle.load(index);
  //     Directory tempDir = await getTemporaryDirectory();

  //     File tempVideo = File("${tempDir.path}/$index")
  //       ..createSync(recursive: true)
  //       ..writeAsBytesSync(byteData.buffer
  //           .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  //     final fileName = await VideoThumbnail.thumbnailFile(
  //       video: tempVideo.path,
  //       thumbnailPath: (await getTemporaryDirectory()).path,
  //       imageFormat: ImageFormat.JPEG,
  //       quality: 100,
  //     );
  //     setState(() {});
  //     thumbFile.add(fileName.toString());
  //   }

  // }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(right: 25),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Videoplayer(videoData: demoVideo[index]),
              ));
        },
        child: VideoPreview(
          fileName: demoName[index],
          // thumbnailURL: thumbFile[index],
        ),
        // child: Image.file(File(thumbFile.toString())),
      ),
      separatorBuilder: (context, index) => const SizedBox(width: 20),
      itemCount: demoVideo.length,
    );
  }
}
