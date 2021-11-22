import 'package:thitsarparami/db/dao/daos.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/helper/enum.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/services/services.dart';

class EbookRespository {
  EbookApiProvider eBookApiProvider;
  // ignore: unnecessary_null_comparison
  EbookRespository(this.eBookApiProvider) : assert(eBookApiProvider != null);

  Future<List<Ebook>> fetchEbooks() async {
    List<Ebook> ebooks = await eBookApiProvider.fetchEbooks();
    final ebookDao = EbookDao();
    final List<Ebook> loadedEbooks = [];
    List<DownloadedEbook> downloadedEbooks = await ebookDao.getEbooks();

    for (var ebook in ebooks) {
      var index = downloadedEbooks
          .indexWhere((downloadedEbook) => downloadedEbook.id == ebook.id);

      loadedEbooks.add(Ebook(
          id: ebook.id,
          thumbnail: ebook.thumbnail,
          title: ebook.title,
          url: ebook.url,
          loadPDF: index >= 0 ? LoadPDF.file : LoadPDF.url));
    }
    return loadedEbooks;
  }
}
