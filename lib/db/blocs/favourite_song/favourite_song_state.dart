part of 'favourite_song_bloc.dart';

abstract class FavouriteSongState extends Equatable {
  const FavouriteSongState();

  @override
  List<Object> get props => [];
}

class FavouriteSongInitial extends FavouriteSongState {}

class FavouriteSongLoading extends FavouriteSongState {}

class FavouriteSongLoadded extends FavouriteSongState {
  final FavouriteSong favouriteSong;
  const FavouriteSongLoadded({required this.favouriteSong});
}

class FavouriteSongSuccess extends FavouriteSongState {
  final String successMessage;
  const FavouriteSongSuccess({required this.successMessage});
}

class FavouriteSongError extends FavouriteSongState {
  final String error;
  const FavouriteSongError({required this.error});
}
