import 'package:thitsarparami/db/dao/daos.dart';
import 'package:thitsarparami/db/dao/song_dao.dart';
import 'package:thitsarparami/db/models/models.dart';

class DownloadRepository {
  final favouriteDao = FavouriteDao();
  final songDao = SongDao();

  Future insertDownload(Favourite favourite) async {
    var result = await favouriteDao.createFavourite(favourite);
    if (favourite.song != null) {
      FavouriteSong song = favourite.song!;
      song.favouriteId = result;
      if (song.id != null && await songDao.isExist(song.id!)) {
        songDao.updateDownloadStatus(
            id: song.id!, status: song.isDownloaded == true ? 1 : 0);
      } else {
        result = await songDao.createSong(favourite.song!);
      }
    }
  }

  Future updateFavouriteStatus(int id, int status) =>
      songDao.updateFavouriteStatus(id: id, status: status);
}
