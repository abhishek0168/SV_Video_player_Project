import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailMaker {
  static Future<List> getThumbnail(List demoVideo) async {
    List<String> videoThumb = [];
    for (var videofile in demoVideo) {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videofile.toString(),
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128,
        quality: 25,
      );

      videoThumb.add(uint8list.toString());
    }
    return videoThumb;
  }
}
