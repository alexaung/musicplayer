import 'package:sqflite/sqflite.dart';
import 'package:thitsarparami/db/database.dart';
import 'package:thitsarparami/db/models/models.dart';

class FavouriteDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Favourite records
  Future<int> createFavourite(Favourite favourite) async {
    final db = await dbProvider.database;
    Future<int> result;

    result = db.insert(favouriteTable, favourite.toDatabaseJson());

    return result;
  }

  //Get All Favourite songs
  //Searches if query string was passed
  //Get All Favourite items
  //Searches if query string was passed
  Future<List<Favourite>> getFavourites() async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;

    result = await db.query(favouriteTable);

    List<Favourite> favourites = result.isNotEmpty
        ? result.map((item) => Favourite.fromDatabaseJson(item)).toList()
        : [];
    return favourites;
  }

  Future<Favourite?> getFavourite({List<String>? columns, int? id}) async {
    final db = await dbProvider.database;

    var result = await db.query(favouriteTable,
        columns: columns, where: 'id = ?', whereArgs: [id]);

    List<Favourite> favourites = result.isNotEmpty
        ? result
            .map((favourite) => Favourite.fromDatabaseJson(favourite))
            .toList()
        : [];
    Favourite? favourite = favourites.isNotEmpty ? favourites[0] : null;

    return favourite;
  }

  //Update Favourite record
  Future<int> updateFavourite(Favourite favourite) async {
    final db = await dbProvider.database;

    var result = await db.update(favouriteTable, favourite.toDatabaseJson(),
        where: "id = ?", whereArgs: [favourite.id]);

    return result;
  }

  //Delete Favourite records
  Future<int> deleteFavourite(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(favouriteTable, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //Delete All Favourite records
  Future deleteAllFavourites() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      favouriteTable,
    );

    return result;
  }

  Future<bool> isExist(int id) async {
    final db = await dbProvider.database;
    var result = await db
        .rawQuery('SELECT EXISTS(SELECT 1 FROM $favouriteTable WHERE id=$id)');
    int? exist = Sqflite.firstIntValue(result);
    return exist == 1;
  }
}
