import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';

part 'favourite_song_list_event.dart';
part 'favourite_song_list_state.dart';

class FavouriteSongListBloc extends Bloc<FavouriteSongListEvent, FavouriteSongListState> {
  final FavouriteSongRepository favouriteSongRespository;
  late List<FavouriteSong> favouriteSongs;

  FavouriteSongListBloc({required this.favouriteSongRespository}) : super(FavouriteSongListInitial());

  @override
  Stream<FavouriteSongListState> mapEventToState(FavouriteSongListEvent event) async* {
    if (event is GetFavouriteSongs) {
      yield FavouriteSongListLoading();
      try {
        final List<FavouriteSong> favouriteSongs = await favouriteSongRespository.fetchFavouriteSongs(event.id);
        yield FavouriteSongListLoaded(favouriteSongs: favouriteSongs);
      } catch (e) {
        yield FavouriteSongListError(error: (e.toString()));
      }
    }
  }
}
