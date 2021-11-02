import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/services/services.dart';

class EbookRespository {
  EbookApiProvider eBookApiProvider;
  // ignore: unnecessary_null_comparison
  EbookRespository(this.eBookApiProvider) : assert(eBookApiProvider != null);

  Future<List<Ebook>> fetchEbooks() async {
    return await eBookApiProvider.fetchEbooks();
  }
}