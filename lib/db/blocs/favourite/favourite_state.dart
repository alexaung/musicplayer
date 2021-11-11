part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class Processing extends FavouriteState {}

class FavouriteListLoading extends FavouriteState {}

class FavouriteListLoaded extends FavouriteState {
  final List<Favourite> favourites;
  const FavouriteListLoaded({required this.favourites});
}

class CreateFavouriteSuccess extends FavouriteState {
  final String successMessage;
  const CreateFavouriteSuccess({required this.successMessage});
}

class CreateDownloadSuccess extends FavouriteState {
  final String successMessage;
  const CreateDownloadSuccess({required this.successMessage});
}

class AddSongInToFavouriteSuccess extends FavouriteState {
  final String successMessage;
  const AddSongInToFavouriteSuccess({required this.successMessage});
}

class DownloadSongInToFavouriteSuccess extends FavouriteState {
  final String successMessage;
  const DownloadSongInToFavouriteSuccess({required this.successMessage});
}

class DeleteSuccess extends FavouriteState {
  final String successMessage;
  const DeleteSuccess({required this.successMessage});
}

class FavouriteError extends FavouriteState {
  final String error;
  const FavouriteError({required this.error});
}
