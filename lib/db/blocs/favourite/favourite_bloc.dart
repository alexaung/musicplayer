import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteRepository favouriteRepository;

  FavouriteBloc({required this.favouriteRepository}) : super(Processing());

  @override
  Stream<FavouriteState> mapEventToState(FavouriteEvent event) async* {
    if (event is GetFavourites) {
      try {
        final List<Favourite> favouriteLists =
            await favouriteRepository.getAllFavourites();

        yield FavouriteListLoaded(favourites: favouriteLists);
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    } else if (event is CreateFavourite) {
      try {
        if (event.favourite != null) {
          Favourite favourite = event.favourite!;
          var result =
              await favouriteRepository.insertFavourite(event.favourite!);

          favourite.id = result;

          List<Favourite> favouriteLists =
              (state as FavouriteListLoaded).favourites..add(favourite);

          yield CreateFavouriteSuccess(
              successMessage:
                  event.favourite!.name! + 'ကို မှတ်တမ်း တင်ပြီးပါပြီ။');
          yield FavouriteListLoaded(favourites: favouriteLists);
        } else {
          yield const FavouriteError(error: ("favourite is null"));
        }
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    } else if (event is CreateDownload) {
      try {
        if (event.favourite != null) {
          Favourite favourite = event.favourite!;

          var result =
              await favouriteRepository.insertDownload(event.favourite!);

          favourite.id = result;

          List<Favourite> favouriteLists =
              (state as FavouriteListLoaded).favourites..add(favourite);

          yield CreateDownloadSuccess(
              successMessage:
                  event.favourite!.name! + 'ကို မှတ်တမ်း တင်ပြီးပါပြီ။');
          yield FavouriteListLoaded(favourites: favouriteLists);
        }
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    } else if (event is AddSongIntoFavourite) {
      try {
        await favouriteRepository.insertFavourite(event.favourite!);

        List<Favourite> favouriteLists =
            (state as FavouriteListLoaded).favourites;

        yield AddSongInToFavouriteSuccess(
            successMessage:
                event.favourite!.name! + 'ကို မှတ်တမ်း တင်ပြီးပါပြီ။');
        yield FavouriteListLoaded(favourites: favouriteLists);
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    } else if (event is DownloadSongIntoFavourite) {
      try {
        await favouriteRepository.insertDownload(event.favourite!);
        List<Favourite> favouriteLists =
            (state as FavouriteListLoaded).favourites;
        yield DownloadSongInToFavouriteSuccess(
            successMessage:
                event.favourite!.name! + 'ကို မှတ်တမ်း တင်ပြီးပါပြီ။');
        yield FavouriteListLoaded(favourites: favouriteLists);
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    } else if (event is DeleteAllSongsByFavouriteId) {
      try {
        List<Favourite> favouriteLists = (state as FavouriteListLoaded)
            .favourites
            .where((favourite) => favourite.id != event.favourite!.id)
            .toList();

        await favouriteRepository
            .deleteAllSongsByFavouriteId(event.favourite!.id!);

        yield DeleteSuccess(
            successMessage: event.favourite!.name! +
                'နှင့်အတူ တရာတော်အားလုံးကို ဖျက်လိုက်ပါပြီ။');
        yield FavouriteListLoaded(favourites: favouriteLists);
      } catch (e) {
        yield FavouriteError(error: (e.toString()));
      }
    }
  }
}
