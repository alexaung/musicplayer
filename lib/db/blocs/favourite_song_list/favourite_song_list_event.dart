part of 'favourite_song_list_bloc.dart';

abstract class FavouriteSongListEvent extends Equatable {
  const FavouriteSongListEvent();
}

class GetFavouriteSongs extends FavouriteSongListEvent {
  final int id;
  const GetFavouriteSongs({required this.id});

  @override
  List<Object> get props => [];
}

class GetAllFavouriteSongsByFavouriteId extends FavouriteSongListEvent {
  final int id;
  const GetAllFavouriteSongsByFavouriteId({required this.id});

  @override
  List<Object> get props => [];
}

class GetAllDownloadedSongsByFavouriteId extends FavouriteSongListEvent {
  final int id;
  const GetAllDownloadedSongsByFavouriteId({required this.id});

  @override
  List<Object> get props => [];
}
