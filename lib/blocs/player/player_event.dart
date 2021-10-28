part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
}

class IsPlayingEvent extends PlayerEvent {
  final bool isPlaying;
  const IsPlayingEvent({required this.isPlaying});

  @override
  List<Object> get props => [];
}
