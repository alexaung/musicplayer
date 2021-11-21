import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';

part 'favourite_song_event.dart';
part 'favourite_song_state.dart';

class FavouriteSongBloc extends Bloc<FavouriteSongEvent, FavouriteSongState> {
  final FavouriteSongRepository favouriteSongRepository;

  FavouriteSongBloc({required this.favouriteSongRepository})
      : super(FavouriteSongInitial()) {
    on<GetFavouriteSong>((event, emit) async {
      await _getFavouriteSong(event.favouriteSong!.id!, emit);
    });
    on<CreateFavouriteSong>((event, emit) async {
      await _createFavouriteSong(event.favouriteSong!, emit);
    });
    on<UpdateFavouriteSong>((event, emit) async {
      await _updateFavouriteSong(event.favouriteSong!, emit);
    });
    on<UpdateSortOrder>((event, emit) async {
      await _updateSortOrder(
          event.id!, event.sortOrder!, event.favouriteSong!, emit);
    });
    on<DeleteFavouriteSong>((event, emit) async {
      await _deleteFavouriteSong(event.favouriteSong!, emit);
    });
  }

  Future<void> _getFavouriteSong(
      int id, Emitter<FavouriteSongState> emit) async {
    emit(FavouriteSongLoading());
    try {
      final FavouriteSong favouriteSong =
          await favouriteSongRepository.getFavouriteSong(id);
      emit(FavouriteSongLoadded(favouriteSong: favouriteSong));
    } catch (e) {
      emit(FavouriteSongError(error: (e.toString())));
    }
  }

  Future<void> _createFavouriteSong(
      FavouriteSong favouriteSong, Emitter<FavouriteSongState> emit) async {
    emit(FavouriteSongLoading());
    try {
      await favouriteSongRepository.insertFavouriteSong(favouriteSong);
      emit(FavouriteSongSuccess(
          successMessage: favouriteSong.title + ' created'));
    } catch (e) {
      emit(FavouriteSongError(error: (e.toString())));
    }
  }

  Future<void> _updateFavouriteSong(
      FavouriteSong favouriteSong, Emitter<FavouriteSongState> emit) async {
    emit(FavouriteSongLoading());
    try {
      await favouriteSongRepository.updateFavouriteSong(favouriteSong);
      emit(FavouriteSongSuccess(
          successMessage: favouriteSong.title + ' updated'));
    } catch (e) {
      emit(FavouriteSongError(error: (e.toString())));
    }
  }

  Future<void> _updateSortOrder(int id, int sortOrder,
      FavouriteSong favouriteSong, Emitter<FavouriteSongState> emit) async {
    emit(FavouriteSongLoading());
    try {
      await favouriteSongRepository.updateSortOrder(id, sortOrder);
      emit(FavouriteSongSuccess(
          successMessage: favouriteSong.title + ' updated'));
    } catch (e) {
      emit(FavouriteSongError(error: (e.toString())));
    }
  }

  Future<void> _deleteFavouriteSong(
      FavouriteSong favouriteSong, Emitter<FavouriteSongState> emit) async {
    emit(FavouriteSongLoading());
    try {
      await favouriteSongRepository.deleteFavouriteSongById(favouriteSong.id!);
      emit(FavouriteSongSuccess(
          successMessage: favouriteSong.title + ' have been deleted'));
    } catch (e) {
      emit(FavouriteSongError(error: (e.toString())));
    }
  }
}
