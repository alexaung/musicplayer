part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumEmpty extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  const AlbumLoaded({required this.albums});
}

class AlbumError extends AlbumState {
  final String error;
  const AlbumError({required this.error});
}
