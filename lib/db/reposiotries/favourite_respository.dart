import 'package:thitsarparami/db/dao/daos.dart';
import 'package:thitsarparami/db/dao/song_dao.dart';
import 'package:thitsarparami/db/models/models.dart';

class FavouriteRepository {
  final favouriteDao = FavouriteDao();
  final songDao = SongDao();

  Future getAllFavourites({String? query}) => favouriteDao.getFavourites();

  Future getFavourite(int id) => favouriteDao.getFavourite(id: id);

  Future insertFavourite(Favourite favourite) async {
    if (favourite.id != null && await favouriteDao.isExist(favourite.id!)) {
      var result = updateFavourite(favourite);
      if (favourite.song != null) {
        FavouriteSong song = favourite.song!;
        if (song.id != null && await songDao.isExist(song.id!)) {
          songDao.updateFavouriteStatus(
              id: song.id!, status: song.isFavourite == true ? 1 : 0);
        } else {
          await songDao.createSong(favourite.song!);
        }
      }
      return result;
    } else {
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
      return result;
    }
  }

  Future updateFavourite(Favourite favourite) =>
      favouriteDao.updateFavourite(favourite);

  Future deleteFavouriteById(int id) => favouriteDao.deleteFavourite(id);

  Future deleteAllFavourites() => favouriteDao.deleteAllFavourites();
}
