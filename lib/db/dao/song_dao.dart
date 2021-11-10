import 'package:sqflite/sqflite.dart';
import 'package:thitsarparami/db/database.dart';
import 'package:thitsarparami/db/models/models.dart';

class SongDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Song records
  Future<int> createSong(FavouriteSong song) async {
    final db = await dbProvider.database;
    Future<int> result;
    if (song.id != null && await isExist(song.id!)) {
      result = updateSong(song);
    } else {
      int order = await getMaxSortOrderByFavourite(song.favouriteId!);
      song.sortOrder = order + 1;
      result = db.insert(songTable, song.toDatabaseJson());
    }

    return result;
  }

  //Get All Song songs
  //Searches if query string was passed
  //Get All Song items
  //Searches if query string was passed
  Future<List<FavouriteSong>> getSongs() async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;

    result = await db.query(songTable);

    List<FavouriteSong> songs = result.isNotEmpty
        ? result.map((item) => FavouriteSong.fromDatabaseJson(item)).toList()
        : [];
    return songs;
  }

  Future<List<FavouriteSong>> getSongsByFavouriteId(int id) async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;

    result = await db.query(songTable, where: 'favouriteId = ?', whereArgs: [id], orderBy: 'sort_order ASC');

    List<FavouriteSong> songs = result.isNotEmpty
        ? result.map((item) => FavouriteSong.fromDatabaseJson(item)).toList()
        : [];
    return songs;
  }

  Future<FavouriteSong?> getSong({List<String>? columns, int? id}) async {
    final db = await dbProvider.database;

    var result = await db
        .query(songTable, columns: columns, where: 'id = ?', whereArgs: [id]);

    List<FavouriteSong> songs = result.isNotEmpty
        ? result.map((song) => FavouriteSong.fromDatabaseJson(song)).toList()
        : [];
    FavouriteSong? song = songs.isNotEmpty ? songs[0] : null;

    return song;
  }

  Future<List<FavouriteSong>> getFavouriteSongs() async {
    final db = await dbProvider.database;

    var result =
        await db.query(songTable, where: 'is_favourite = ?', whereArgs: [1]);

    List<FavouriteSong> songs = result.isNotEmpty
        ? result.map((song) => FavouriteSong.fromDatabaseJson(song)).toList()
        : [];

    return songs;
  }

  //Update Song record
  Future<int> updateSong(FavouriteSong song) async {
    final db = await dbProvider.database;

    var result = await db.update(songTable, song.toDatabaseJson(),
        where: "id = ?", whereArgs: [song.id]);

    return result;
  }

  Future<int> updateFavouriteStatus(
      {required int id, required int status}) async {
    final db = await dbProvider.database;
    var result = await db.rawUpdate('''
    UPDATE $songTable  
    SET is_favourite = ?
    WHERE id = ?
    ''', [status, id]);

    return result;
  }

  Future<int> updateDownloadStatus(
      {required int id, required int status}) async {
    final db = await dbProvider.database;
    var result = await db.rawUpdate('''
    UPDATE $songTable  
    SET is_downloaded = ?
    WHERE id = ?
    ''', [status, id]);

    return result;
  }

  Future<int> updateSortOrder(
      {required int id, required int sortOrder}) async {
    final db = await dbProvider.database;
    var result = await db.rawUpdate('''
    UPDATE $songTable  
    SET sort_order = ?
    WHERE id = ?
    ''', [sortOrder, id]);

    return result;
  }

  //Delete Song records
  Future<int> deleteSong(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(songTable, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //Delete All Song records
  Future deleteAllSongs() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      songTable,
    );

    return result;
  }

  Future<bool> isExist(int id) async {
    final db = await dbProvider.database;
    var result = await db
        .rawQuery('SELECT EXISTS(SELECT 1 FROM $songTable WHERE id=$id)');
    int? exist = Sqflite.firstIntValue(result);
    return exist == 1;
  }

  Future<int> getMaxSortOrderByFavourite(int id) async {
    final db = await dbProvider.database;
    var result = await db.rawQuery('SELECT MAX(sort_order) FROM $songTable WHERE favouriteId=?', [id]);
    int? order = Sqflite.firstIntValue(result);
    return order ?? 0;
  }
}
