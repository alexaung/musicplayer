import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final DownloadRepository downloadRepository;

  DownloadBloc({required this.downloadRepository}) : super(DownloadInitial());

  @override
  Stream<DownloadState> mapEventToState(DownloadEvent event) async* {
    yield Downloading();
    if (event is GetDownloaded) {
      if (event is CreateDownload) {
        try {
          await downloadRepository.insertDownload(event.favourite!);
          yield DownloadSuccess(successMessage: event.favourite!.name! + ' created');
        } catch (e) {
          yield DownloadError(error: (e.toString()));
        }
      } else if (event is UpdateDownloadStatus) {
        try {
          await downloadRepository.updateFavouriteStatus(
              event.id!, event.status == true ? 1 : 0);
          yield DownloadSuccess(successMessage: event.favourite!.name! + ' updated');
        } catch (e) {
          yield DownloadError(error: (e.toString()));
        }
      }
    }
  }
}
