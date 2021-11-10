part of 'favourite_list_bloc.dart';

abstract class FavouriteListEvent extends Equatable {
  const FavouriteListEvent();
}

class GetFavourites extends FavouriteListEvent {
  const GetFavourites();

  @override
  List<Object> get props => [];
}
