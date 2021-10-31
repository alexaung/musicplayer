import 'package:thitsarparami/db/models/models.dart';

class Favourite {
  int? id;
  String? name;
  FavouriteSong? song;
  Favourite({this.id, this.name, this.song});

  factory Favourite.fromDatabaseJson(Map<String, dynamic> data) => Favourite(
        id: data['id'],
        name: data['name'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "name": name,
      };
}
