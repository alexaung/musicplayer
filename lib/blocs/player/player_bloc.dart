import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(Initial()) {
    on<IsPlayingEvent>((event, emit) {
      _isPlaying(event.isPlaying, emit);
    });
  }

  void _isPlaying(bool isPlaying, Emitter<PlayerState> emit) {
    emit(Initial());
    try {
      emit(Playing(isPlaying: isPlaying));
    } catch (e) {
      emit(Error(error: (e.toString())));
    }
  }
}
