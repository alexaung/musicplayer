part of 'song_bloc.dart';

abstract class SongState extends Equatable {
  const SongState();

  @override
  List<Object> get props => [];
}

class SongEmpty extends SongState {}

class SongLoading extends SongState {}

class SongInitial extends SongState {}

class SongLoaded extends SongState {
  final List<Song> songs;
  const SongLoaded({required this.songs});
}

class SongError extends SongState {
  final String error;
  const SongError({required this.error});
}
