import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final SongRespository songRespository;
  late List<Song> songs;

  SongBloc({required this.songRespository}) : super(SongInitial()) {
    on<GetSongsEvent>((event, emit) async {
      await _getSongs(event.id, emit);
    });
  }

  Future<void> _getSongs(int id, Emitter<SongState> emit) async {
    emit(SongLoading());
    try {
      final List<Song> songs = await songRespository.fetchSongs(id);
      emit(SongLoaded(songs: songs));
    } catch (e) {
      emit(SongError(error: (e.toString())));
    }
  }
}
