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

// class UpdateFavouriteStatus extends FavouriteEvent {
//   const UpdateFavouriteStatus({required int id, bool status = false})
//       : super(id: id, status: status);
// }

class DeleteFavourite extends FavouriteEvent {
  const DeleteFavourite({required int id}) : super(id: id);
}

class DeleteAllFavourite extends FavouriteEvent {
  const DeleteAllFavourite() : super();
}
