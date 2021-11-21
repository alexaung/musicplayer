import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRespository albumRespository;
  late List<Album> albums;
  AlbumBloc({required this.albumRespository}) : super(AlbumInitial()) {
    on<GetAlbumsEvent>((event, emit) async {
      await _getAbout(emit);
    });
  }

  Future<void> _getAbout(Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      final List<Album> albums = await albumRespository.fetchAlbums();
      emit(AlbumLoaded(albums: albums));
    } catch (e) {
      emit(AlbumError(error: (e.toString())));
    }
  }
}
