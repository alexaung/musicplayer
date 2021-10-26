import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/services/services.dart';

class AlbumRespository {
  AlbumApiProvider albumApiProvider;
  // ignore: unnecessary_null_comparison
  AlbumRespository(this.albumApiProvider) : assert(albumApiProvider != null);

  Future<List<Album>> fetchAlbums() async {
    return await albumApiProvider.fetchAlbums();
  }
}