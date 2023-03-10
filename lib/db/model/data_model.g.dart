// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoModelAdapter extends TypeAdapter<VideoModel> {
  @override
  final int typeId = 1;

  @override
  VideoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoModel(
      id: fields[0] as int?,
      videoUrl: fields[1] as String,
      videoName: fields[2] as String,
      videoDuration: fields[3] as String,
      videoFavourite: fields[4] as bool,
      videoThumbnail: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.videoUrl)
      ..writeByte(2)
      ..write(obj.videoName)
      ..writeByte(3)
      ..write(obj.videoDuration)
      ..writeByte(4)
      ..write(obj.videoFavourite)
      ..writeByte(5)
      ..write(obj.videoThumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
