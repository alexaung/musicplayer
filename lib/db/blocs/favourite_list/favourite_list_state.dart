part of 'favourite_list_bloc.dart';

abstract class FavouriteListState extends Equatable {
  const FavouriteListState();

  @override
  List<Object> get props => [];
}

class FavouriteListInitial extends FavouriteListState {}

class FavouriteListLoading extends FavouriteListState {}

class FavouriteListLoaded extends FavouriteListState {
  final List<Favourite> favourites;
  const FavouriteListLoaded({required this.favourites});
}

class FavouriteListError extends FavouriteListState {
  final String error;
  const FavouriteListError({required this.error});
}