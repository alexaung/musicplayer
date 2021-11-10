import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

const favouriteTable = 'Favourite';
const songTable = 'Song';

class DatabaseProvider {
  static const _databaseName = "Thitsarparami.db";
  static const _databaseVersion = 1;
  static final DatabaseProvider dbProvider = DatabaseProvider();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await createDatabase();
  }

  Future<Database> createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    //Thitsarparami is our database instance name
    String path = join(documentsDirectory.path, _databaseName);

    var database = await openDatabase(path,
        version: _databaseVersion, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //THis is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldversion, int newVersion) {
    if (newVersion > oldversion) {}
  }

  void initDB(Database database, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER';

    String sql = "CREATE TABLE $favouriteTable ("
        "id $idType, "
        "name $textType"
        ")";

    await database.execute("DROP TABLE IF EXISTS $favouriteTable");
    await database.execute(sql);

    sql = "CREATE TABLE $songTable ("
        "id $idType, "
        "favouriteId $integerType, "
        "album $textType, "
        "title $textType, "
        "artist $textType, "
        "artUrl $textType, "
        "audioUrl $textType, "
        "is_favourite $integerType, "
        "is_downloaded $integerType, "
        "sort_order $integerType"
        ")";

    await database.execute(sql);

    sql = "INSERT INTO $favouriteTable (id, name)"
        " VALUES (?,?)";

        await database.execute(sql, [1, "Downloaded"] );
  }

//   Future<void> deleteDatabase() async {
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, _databaseName);

// // Delete the database
//     await deleteDatabase(path);
//   }
}
