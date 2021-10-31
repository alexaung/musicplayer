part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  final Favourite? favourite;
  final int? id;
  const FavouriteEvent({
    this.id,
    this.favourite,
  });

  @override
  List<Object> get props => [];
}

class GetFavourites extends FavouriteEvent {
  const GetFavourites();
}

class GetFavourite extends FavouriteEvent {
  const GetFavourite({required Favourite favourite})
      : super(favourite: favourite);
}

class CreateFavourite extends FavouriteEvent {
  const CreateFavourite({required Favourite favourite})
      : super(favourite: favourite);
}

class UpdateFavourite extends FavouriteEvent {
  const UpdateFavourite({required Favourite favourite})
      : super(favourite: favourite);
}

class DeleteFavourite extends FavouriteEvent {
  const DeleteFavourite({required int id}) : super(id: id);
}

class DeleteAllFavourite extends FavouriteEvent {
  const DeleteAllFavourite() : super();
}
