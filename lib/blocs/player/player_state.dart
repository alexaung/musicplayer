part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class Initial extends PlayerState {}

class Playing extends PlayerState {
  final bool isPlaying;
  const Playing({required this.isPlaying});
}

class Error extends PlayerState {
  final String error;
  const Error({required this.error});
}