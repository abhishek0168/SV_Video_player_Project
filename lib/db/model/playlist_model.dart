import 'package:hive_flutter/adapters.dart';
import 'package:sv_video_app/db/model/data_model.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 2)
class PlaylistModel {
  @HiveField(1)
  int? id;

  @HiveField(2)
  List<VideoModel> playlistItem;

  @HiveField(3)
  String playlistName;

  PlaylistModel(
      {this.id, required this.playlistItem, required this.playlistName});
}
