import 'package:sqflite/sqflite.dart';
import 'package:thitsarparami/db/database.dart';
import 'package:thitsarparami/db/models/models.dart';

class EbookDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Song records
  Future<int> createEbook(DownloadedEbook ebook) async {
    final db = await dbProvider.database;
    var result = db.insert(ebookTable, ebook.toDatabaseJson());

    return result;
  }

  //Get All Song songs
  //Searches if query string was passed
  //Get All Song items
  //Searches if query string was passed
  Future<List<DownloadedEbook>> getEbooks() async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;

    result = await db.query(ebookTable);

    List<DownloadedEbook> ebooks = result.isNotEmpty
        ? result.map((item) => DownloadedEbook.fromDatabaseJson(item)).toList()
        : [];
    return ebooks;
  }

  Future<DownloadedEbook?> getEbook({List<String>? columns, int? id}) async {
    final db = await dbProvider.database;

    var result = await db
        .query(ebookTable, columns: columns, where: 'id = ?', whereArgs: [id]);

    List<DownloadedEbook> ebooks = result.isNotEmpty
        ? result.map((ebook) => DownloadedEbook.fromDatabaseJson(ebook)).toList()
        : [];
    DownloadedEbook? book = ebooks.isNotEmpty ? ebooks[0] : null;

    return book;
  }

  //Update Song record
  Future<int> updateEbook(DownloadedEbook ebook) async {
    final db = await dbProvider.database;

    var result = await db.update(ebookTable, ebook.toDatabaseJson(),
        where: "id = ?", whereArgs: [ebook.id]);

    return result;
  }

  

  //Delete Song records
  Future<int> deleteEbook(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(ebookTable, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //Delete All Song records
  Future deleteAllEbooks() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      ebookTable,
    );

    return result;
  }

  Future<bool> isExist(int id) async {
    final db = await dbProvider.database;
    var result = await db
        .rawQuery('SELECT EXISTS(SELECT 1 FROM $ebookTable WHERE id=$id)');
    int? exist = Sqflite.firstIntValue(result);
    return exist == 1;
  }
}
