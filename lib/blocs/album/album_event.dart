part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();
}

class GetAlbumsEvent extends AlbumEvent {
  const GetAlbumsEvent();
  @override
  List<Object> get props => [];
}

