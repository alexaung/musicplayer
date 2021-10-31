import 'package:thitsarparami/db/dao/song_dao.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/services/services.dart';

class SongRespository {
  SongApiProvider songApiProvider;
  // ignore: unnecessary_null_comparison
  SongRespository(this.songApiProvider) : assert(songApiProvider != null);

  Future<List<Song>> fetchSongs(int ablbumId) async {
    List<Song> songs = await songApiProvider.fetchSongs(ablbumId);
    final songDao = SongDao();
    final List<Song> loadedSongs = [];
    List<FavouriteSong> favouriteSongs = await songDao.getFavouriteSongs();

    for (var song in songs) {
        var isExist = favouriteSongs
            .indexWhere((favouriteSong) => favouriteSong.id == song.id);
        loadedSongs.add(Song(
            id: song.id,
            title: song.title,
            url: song.url,
            isFavourite: isExist > -1 ? true : false));
      }
    return loadedSongs;
  }
}
