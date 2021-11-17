import 'package:thitsarparami/db/dao/daos.dart';
import 'package:thitsarparami/db/models/models.dart';

class DownloadedEbookRepository {
  final ebookDao = EbookDao();

  Future fetchEbooks() => ebookDao.getEbooks();

  Future getEbook(int id) => ebookDao.getEbook(id: id);

  Future insertEbook(DownloadedEbook ebook) =>
      ebookDao.createEbook(ebook);

  Future updateEbook(DownloadedEbook ebook) =>
      ebookDao.updateEbook(ebook);

  Future deleteEbook(int id) => ebookDao.deleteEbook(id);

  Future deleteAllEbooks() => ebookDao.deleteAllEbooks();
}
