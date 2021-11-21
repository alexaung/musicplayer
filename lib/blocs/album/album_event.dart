part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();
}

class GetAlbumsEvent extends AlbumEvent {
  const GetAlbumsEvent();
  @override
  List<Object> get props => [];
}

class AlbumSearchEvent extends AlbumEvent {
  final int monkId;
  final String query;
  const AlbumSearchEvent(this.monkId, this.query);

  @override
  List<Object> get props => [];
}

