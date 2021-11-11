part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  final Favourite? favourite;
  final int? id;
  final bool status;
  const FavouriteEvent({
    this.id,
    this.favourite,
    this.status = false
  });

  @override
  List<Object> get props => [];
}

class GetFavourites extends FavouriteEvent {
  const GetFavourites();

  @override
  List<Object> get props => [];
}

class CreateFavourite extends FavouriteEvent {
  const CreateFavourite({required Favourite favourite})
      : super(favourite: favourite);
}

class CreateDownload extends FavouriteEvent {
  const CreateDownload({required Favourite favourite})
      : super(favourite: favourite);
}

class AddSongIntoFavourite extends FavouriteEvent {
  const AddSongIntoFavourite({required Favourite favourite})
      : super(favourite: favourite);
}

class DownloadSongIntoFavourite extends FavouriteEvent {
  const DownloadSongIntoFavourite({required Favourite favourite})
      : super(favourite: favourite);
}

class DeleteAllSongsByFavouriteId extends FavouriteEvent {
  const DeleteAllSongsByFavouriteId({required Favourite favourite})
      : super(favourite: favourite);
}
