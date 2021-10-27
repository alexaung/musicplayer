import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/services/services.dart';

class SongRespository {
  SongApiProvider songApiProvider;
  // ignore: unnecessary_null_comparison
  SongRespository(this.songApiProvider) : assert(songApiProvider != null);

  Future<List<Song>> fetchSongs(int id) async {
    return await songApiProvider.fetchSongs(id);
  }
}
