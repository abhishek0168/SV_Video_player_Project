import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class VideoModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String videoUrl;

  @HiveField(2)
  final String videoName;

  @HiveField(3)
  final String videoDuration;

  @HiveField(4)
  bool videoFavourite = false;

  @HiveField(5)
  String? videoThumbnail;

  VideoModel({
    this.id,
    required this.videoUrl,
    required this.videoName,
    required this.videoDuration,
    required this.videoFavourite,
    this.videoThumbnail,
  });
}
