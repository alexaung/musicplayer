import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteRepository favouriteRepository;

  FavouriteBloc({required this.favouriteRepository})
      : super(FavouriteInitial());

  @override
  Stream<FavouriteState> mapEventToState(FavouriteEvent event) async* {
    yield Loading();
    if (event is GetFavourite) {
      try {
        final Favourite favourite =
            await favouriteRepository.getFavourite(event.id!);
        yield Loadded(favourite: favourite);
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    } else if (event is GetFavourites) {
      try {
        final List<Favourite> favourites =
            await favouriteRepository.getAllFavourites();
        yield ListLoaded(favourites: favourites);
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    } else if (event is CreateFavourite) {
      try {
        await favouriteRepository.insertFavourite(event.favourite!);
        yield Success(successMessage: event.favourite!.name! + ' created');
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    } else if (event is UpdateFavourite) {
      try {
        await favouriteRepository.updateFavourite(event.favourite!);
        yield Success(successMessage: event.favourite!.name! + ' updated');
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    } else if (event is DeleteFavourite) {
      try {
        await favouriteRepository.deleteFavouriteById(event.id!);
        yield Success(
            successMessage: event.favourite!.name! + ' have been deleted');
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    } else if (event is DeleteFavourite) {
      try {
        await favouriteRepository.deleteFavouriteById(event.id!);
        yield Success(
            successMessage: event.favourite!.name! + ' have been deleted');
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    } else if (event is DeleteAllFavourite) {
      try {
        await favouriteRepository.deleteAllFavourites();
        yield const Success(successMessage: "All favourites have been deleted");
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    }
  }
}
