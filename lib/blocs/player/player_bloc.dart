import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  

  PlayerBloc() : super(Initial());

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    if (event is IsPlayingEvent) {
      yield Initial();
      try {
        yield Playing(isPlaying: event.isPlaying);
      } catch (e) {
        yield Error(error: (e.toString()));
      }
    }
  }
}
