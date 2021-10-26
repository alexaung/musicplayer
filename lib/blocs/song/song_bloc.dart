import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final SongRespository songRespository;
  late List<Song> songs;

  SongBloc({required this.songRespository}) : super(SongInitial());

  @override
  Stream<SongState> mapEventToState(SongEvent event) async* {
    if (event is GetSongsEvent) {
      yield SongLoading();
      try {
        final List<Song> songs = await songRespository.fetchSongs();
        yield SongLoaded(songs: songs);
      } catch (e) {
        yield SongError(error: (e.toString()));
      }
    }
  }
}


