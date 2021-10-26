part of 'song_bloc.dart';

abstract class SongEvent extends Equatable {
  const SongEvent();
}

class GetSongsEvent extends SongEvent {
  const GetSongsEvent();

  @override
  List<Object> get props => [];
}
