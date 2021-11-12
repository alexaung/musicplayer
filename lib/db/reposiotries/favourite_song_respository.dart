import 'package:thitsarparami/db/dao/song_dao.dart';
import 'package:thitsarparami/db/models/models.dart';

class FavouriteSongRepository {
  final songDao = SongDao();

  Future fetchFavouriteSongs(int id) => songDao.getSongsByFavouriteId(id);

  Future fetchAllFavouriteSongsById(int id) => songDao.getFavouriteSongsById(id);

  Future fetchAllDownloadedSongsById(int id) => songDao.getAllDownloadedSongsById(id);

  Future getFavouriteSong(int id) => songDao.getSong(id: id);

  Future insertFavouriteSong(FavouriteSong favouriteSong) =>
      songDao.createSong(favouriteSong);

  Future updateFavouriteSong(FavouriteSong favouriteSong) =>
      songDao.updateSong(favouriteSong);

  Future updateFavouriteStatus(int id, int status) =>
      songDao.updateFavouriteStatus(id: id, status: status);

  Future updateDownloadStatus(int id, int status) =>
      songDao.updateDownloadStatus(id: id, status: status);

      Future updateSortOrder(int id, int sortOrder) =>
      songDao.updateSortOrder(id: id, sortOrder: sortOrder);

  Future deleteFavouriteSongById(int id) => songDao.deleteSong(id);

  Future deleteAllFavouriteSongs() => songDao.deleteAllSongs();
}
