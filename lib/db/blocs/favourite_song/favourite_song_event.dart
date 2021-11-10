part of 'favourite_song_bloc.dart';

abstract class FavouriteSongEvent extends Equatable {
  final FavouriteSong? favouriteSong;
  final int? id;
  final bool status;
  final int? sortOrder;
  const FavouriteSongEvent({
    this.id,
    this.sortOrder,
    this.status = false,
    this.favouriteSong,
  });

  @override
  List<Object> get props => [];
}

class GetFavouriteSong extends FavouriteSongEvent {
  const GetFavouriteSong({required FavouriteSong favouriteSong})
      : super(favouriteSong: favouriteSong);
}

class CreateFavouriteSong extends FavouriteSongEvent {
  const CreateFavouriteSong({required FavouriteSong favouriteSong})
      : super(favouriteSong: favouriteSong);
}

class UpdateFavouriteSong extends FavouriteSongEvent {
  const UpdateFavouriteSong({required FavouriteSong favouriteSong})
      : super(favouriteSong: favouriteSong);
}

class UpdateFavouriteStatus extends FavouriteSongEvent {
  const UpdateFavouriteStatus({required int id, bool status = false})
      : super(id: id, status: status);
}

class UpdateSortOrder extends FavouriteSongEvent {
  const UpdateSortOrder({required int id, required int sortOrder})
      : super(id: id, sortOrder: sortOrder);
}

class DeleteFavouriteSong extends FavouriteSongEvent {
  const DeleteFavouriteSong({required FavouriteSong favouriteSong})
      : super(favouriteSong: favouriteSong);
}

class DeleteAllFavouriteSong extends FavouriteSongEvent {
  const DeleteAllFavouriteSong() : super();
}
