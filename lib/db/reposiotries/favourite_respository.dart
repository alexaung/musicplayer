import 'package:thitsarparami/db/dao/daos.dart';
import 'package:thitsarparami/db/dao/song_dao.dart';
import 'package:thitsarparami/db/models/models.dart';

class FavouriteRepository {
  final favouriteDao = FavouriteDao();
  final songDao = SongDao();

  Future getAllFavourites({String? query}) => favouriteDao.getFavourites();

  Future getFavourite(int id) => favouriteDao.getFavourite(id: id);

  Future insertFavourite(Favourite favourite) async {
    var result = await favouriteDao.createFavourite(favourite);
    if (favourite.song != null) {
      FavouriteSong song = favourite.song!;
      song.favouriteId = result;
      if (song.id != null && await songDao.isExist(song.id!)) {
        songDao.updateFavouriteStatus(
            id: song.id!, status: song.isFavourite == true ? 1 : 0);
      } else {
        result = await songDao.createSong(favourite.song!);
      }
    }
  }

  Future updateFavourite(Favourite favourite) =>
      favouriteDao.updateFavourite(favourite);

  Future updateFavouriteStatus(int id, int status) =>
      songDao.updateFavouriteStatus(id: id, status: status);

  Future deleteFavouriteById(int id) => favouriteDao.deleteFavourite(id);

  Future deleteAllFavourites() => favouriteDao.deleteAllFavourites();
}
