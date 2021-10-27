part of 'song_bloc.dart';

abstract class SongEvent extends Equatable {
  const SongEvent();
}

class GetSongsEvent extends SongEvent {
  final int id;
  const GetSongsEvent({required this.id});

  @override
  List<Object> get props => [];
}
