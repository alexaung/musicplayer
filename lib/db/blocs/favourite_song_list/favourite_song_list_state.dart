part of 'favourite_song_list_bloc.dart';

abstract class FavouriteSongListState extends Equatable {
  const FavouriteSongListState();

  @override
  List<Object> get props => [];
}

class FavouriteSongListEmpty extends FavouriteSongListState {}

class FavouriteSongListLoading extends FavouriteSongListState {}

class FavouriteSongListInitial extends FavouriteSongListState {}

class FavouriteSongListLoaded extends FavouriteSongListState {
  final List<FavouriteSong> favouriteSongs;
  const FavouriteSongListLoaded({required this.favouriteSongs});
}

class AllFavouriteSongListLoaded extends FavouriteSongListState {
  final List<FavouriteSong> favouriteSongs;
  const AllFavouriteSongListLoaded({required this.favouriteSongs});
}

class AllDownloadedSongListLoaded extends FavouriteSongListState {
  final List<FavouriteSong> favouriteSongs;
  const AllDownloadedSongListLoaded({required this.favouriteSongs});
}

class FavouriteSongListError extends FavouriteSongListState {
  final String error;
  const FavouriteSongListError({required this.error});
}
