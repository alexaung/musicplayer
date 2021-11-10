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

class FavouriteSongListError extends FavouriteSongListState {
  final String error;
  const FavouriteSongListError({required this.error});
}
