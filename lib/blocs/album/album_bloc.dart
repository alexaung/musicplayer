import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRespository albumRespository;
  late List<Album> albums;
  AlbumBloc({required this.albumRespository}) : super(AlbumInitial());

  @override
  Stream<AlbumState> mapEventToState(AlbumEvent event) async* {
    if (event is GetAlbumsEvent) {
      yield AlbumLoading();
      try {
        final List<Album> albums = await albumRespository.fetchAlbums();
        yield AlbumLoaded(albums: albums);
      } catch (e) {
        yield AlbumError(error: (e.toString()));
      }
    }
  }
}
