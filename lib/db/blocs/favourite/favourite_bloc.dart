import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteRepository favouriteRepository;

  FavouriteBloc({required this.favouriteRepository}) : super(Processing()) {
    on<GetFavourites>((event, emit) async {
      await _getFavourites(emit);
    });
    on<CreateFavourite>((event, emit) async {
      await _createFavourite(event.favourite!, emit);
    });
    on<CreateDownload>((event, emit) async {
      await _createDownload(event.favourite!, emit);
    });
    on<AddSongIntoFavourite>((event, emit) async {
      await _addSongIntoFavourite(event.favourite!, emit);
    });
    on<DownloadSongIntoFavourite>((event, emit) async {
      await _downloadSongIntoFavourite(event.favourite!, emit);
    });
    on<DeleteAllSongsByFavouriteId>((event, emit) async {
      await _deleteAllSongsByFavouriteId(event.favourite!, emit);
    });
  }

  Future<void> _getFavourites(Emitter<FavouriteState> emit) async {
    try {
      final List<Favourite> favouriteLists =
          await favouriteRepository.getAllFavourites();
      emit(FavouriteListLoaded(favourites: favouriteLists));
    } catch (e) {
      emit(FavouriteError(error: (e.toString())));
    }
  }

  Future<void> _createFavourite(
      Favourite favourite, Emitter<FavouriteState> emit) async {
    try {
      // ignore: unnecessary_null_comparison
      if (favourite != null) {
        var result = await favouriteRepository.insertFavourite(favourite);

        favourite.id = result;

        List<Favourite> favouriteLists =
            (state as FavouriteListLoaded).favourites..add(favourite);

        emit(CreateFavouriteSuccess(
            successMessage: favourite.name! + 'ကို မှတ်တမ်း တင်ပြီးပါပြီ။'));
        emit(FavouriteListLoaded(favourites: favouriteLists));
      } else {
        emit(const FavouriteError(error: ("favourite is null")));
      }
    } catch (e) {
      emit(FavouriteError(error: (e.toString())));
    }
  }

  Future<void> _createDownload(
      Favourite favourite, Emitter<FavouriteState> emit) async {
    try {
      // ignore: unnecessary_null_comparison
      if (favourite != null) {
        var result = await favouriteRepository.insertDownload(favourite);

        favourite.id = result;

        List<Favourite> favouriteLists =
            (state as FavouriteListLoaded).favourites..add(favourite);

        emit(CreateDownloadSuccess(
            successMessage: favourite.name! + 'ကို မှတ်တမ်း တင်ပြီးပါပြီ။'));
        emit(FavouriteListLoaded(favourites: favouriteLists));
      }
    } catch (e) {
      emit(FavouriteError(error: (e.toString())));
    }
  }

  Future<void> _addSongIntoFavourite(
      Favourite favourite, Emitter<FavouriteState> emit) async {
    try {
      await favouriteRepository.insertFavourite(favourite);

      List<Favourite> favouriteLists =
          (state as FavouriteListLoaded).favourites;

      emit(AddSongInToFavouriteSuccess(
          successMessage: favourite.name! + 'ကို မှတ်တမ်း တင်ပြီးပါပြီ။'));
      emit(FavouriteListLoaded(favourites: favouriteLists));
    } catch (e) {
      emit(FavouriteError(error: (e.toString())));
    }
  }

  Future<void> _downloadSongIntoFavourite(
      Favourite favourite, Emitter<FavouriteState> emit) async {
    try {
      await favouriteRepository.insertDownload(favourite);
      List<Favourite> favouriteLists =
          (state as FavouriteListLoaded).favourites;
      emit(DownloadSongInToFavouriteSuccess(
          successMessage: favourite.name! + 'ကို မှတ်တမ်း တင်ပြီးပါပြီ။'));
      emit(FavouriteListLoaded(favourites: favouriteLists));
    } catch (e) {
      emit(FavouriteError(error: (e.toString())));
    }
  }

  Future<void> _deleteAllSongsByFavouriteId(
      Favourite favourite, Emitter<FavouriteState> emit) async {
    try {
      List<Favourite> favouriteLists = (state as FavouriteListLoaded)
          .favourites
          .where((favourite) => favourite.id != favourite.id)
          .toList();

      await favouriteRepository.deleteAllSongsByFavouriteId(favourite.id!);

      emit(DeleteSuccess(
          successMessage:
              favourite.name! + 'နှင့်အတူ တရာတော်အားလုံးကို ဖျက်လိုက်ပါပြီ။'));
      emit(FavouriteListLoaded(favourites: favouriteLists));
    } catch (e) {
      emit(FavouriteError(error: (e.toString())));
    }
  }
}
