import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';

part 'favourite_song_list_event.dart';
part 'favourite_song_list_state.dart';

class FavouriteSongListBloc
    extends Bloc<FavouriteSongListEvent, FavouriteSongListState> {
  final FavouriteSongRepository favouriteSongRespository;
  late List<FavouriteSong> favouriteSongs;

  FavouriteSongListBloc({required this.favouriteSongRespository})
      : super(FavouriteSongListInitial()){
    on<GetFavouriteSongs>((event, emit) async {
      await _getFavouriteSongs(event.id, emit);
    });
    on<GetAllFavouriteSongsByFavouriteId>((event, emit) async {
      await _getAllFavouriteSongsByFavouriteId(event.id, emit);
    });
    
  }

  Future<void> _getFavouriteSongs(int id, Emitter<FavouriteSongListState> emit) async {
    emit(FavouriteSongListLoading());
    try {
      final List<FavouriteSong> favouriteSongs =
            await favouriteSongRespository.fetchFavouriteSongs(id);
      emit(FavouriteSongListLoaded(favouriteSongs: favouriteSongs));
    } catch (e) {
      emit(FavouriteSongListError(error: (e.toString())));
    }
  }

  Future<void> _getAllFavouriteSongsByFavouriteId(int id, Emitter<FavouriteSongListState> emit) async {
    emit(FavouriteSongListLoading());
    try {
      final List<FavouriteSong> favouriteSongs =
            await favouriteSongRespository.fetchAllFavouriteSongsById(id);
      emit(FavouriteSongListLoaded(favouriteSongs: favouriteSongs));
    } catch (e) {
      emit(FavouriteSongListError(error: (e.toString())));
    }
  }
}
