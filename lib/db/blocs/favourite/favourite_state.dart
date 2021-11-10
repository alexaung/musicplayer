part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class Loading extends FavouriteState {}

class Loadded extends FavouriteState {
  final Favourite favourite;
  const Loadded({required this.favourite});
}

class Success extends FavouriteState {
  final String successMessage;
  const Success({required this.successMessage});
}

class FavouriteError extends FavouriteState {
  final String error;
  const FavouriteError({required this.error});
}
