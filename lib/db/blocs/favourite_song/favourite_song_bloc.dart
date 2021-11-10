import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';

part 'favourite_song_event.dart';
part 'favourite_song_state.dart';

class FavouriteSongBloc extends Bloc<FavouriteSongEvent, FavouriteSongState> {
  final FavouriteSongRepository favouriteSongRepository;

  FavouriteSongBloc({required this.favouriteSongRepository})
      : super(FavouriteSongInitial());

  @override
  Stream<FavouriteSongState> mapEventToState(FavouriteSongEvent event) async* {
    yield FavouriteSongLoading();
    if (event is GetFavouriteSong) {
      try {
        final FavouriteSong favouriteSong = await favouriteSongRepository
            .getFavouriteSong(event.favouriteSong!.id!);
        yield FavouriteSongLoadded(favouriteSong: favouriteSong);
      } catch (e) {
        yield FavouriteSongError(error: (e.toString()));
      }
    } else if (event is CreateFavouriteSong) {
      try {
        await favouriteSongRepository.insertFavouriteSong(event.favouriteSong!);
        yield FavouriteSongSuccess(
            successMessage: event.favouriteSong!.title + ' created');
      } catch (e) {
        yield FavouriteSongError(error: (e.toString()));
      }
    } else if (event is UpdateFavouriteSong) {
      try {
        await favouriteSongRepository.updateFavouriteSong(event.favouriteSong!);
        yield FavouriteSongSuccess(
            successMessage: event.favouriteSong!.title + ' updated');
      } catch (e) {
        yield FavouriteSongError(error: (e.toString()));
      }
    } else if (event is UpdateSortOrder) {
      try {
        await favouriteSongRepository.updateSortOrder(
            event.id!, event.sortOrder!);
        yield FavouriteSongSuccess(
            successMessage: event.favouriteSong!.title + ' updated');
      } catch (e) {
        yield FavouriteSongError(error: (e.toString()));
      }
    } else if (event is DeleteFavouriteSong) {
      try {
        await favouriteSongRepository
            .deleteFavouriteSongById(event.favouriteSong!.id!);
        yield FavouriteSongSuccess(
            successMessage: event.favouriteSong!.title + ' have been deleted');
      } catch (e) {
        yield FavouriteSongError(error: (e.toString()));
      }
    } else if (event is DeleteAllFavouriteSong) {
      try {
        await favouriteSongRepository.deleteAllFavouriteSongs();
        yield const FavouriteSongSuccess(
            successMessage: "All FavouriteSongs have been deleted");
      } catch (e) {
        yield FavouriteSongError(error: (e.toString()));
      }
    }
  }
}
