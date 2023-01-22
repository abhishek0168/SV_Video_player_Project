import 'package:flutter/cupertino.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 0,
        crossAxisSpacing: 30,
      ),
      itemBuilder: (context, index) {
        return VideoPreview(fileName: 'Demo - ${index + 1}');
      },
      itemCount: 13,
    );
  }
}
