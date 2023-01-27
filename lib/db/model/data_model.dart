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

  VideoModel(
      {required this.videoUrl,
      required this.videoName,
      required this.videoDuration});
}
