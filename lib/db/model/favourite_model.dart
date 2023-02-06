import 'package:hive/hive.dart';
part 'favourite_model.g.dart';

@HiveType(typeId: 2)
class FavouriteModel {
  @HiveField(0)
  int? key;

  @HiveField(1)
  final String favouriteUrl;

  FavouriteModel({this.key, required this.favouriteUrl});
}
