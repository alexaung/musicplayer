part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable {
  final Favourite? favourite;
  final int? id;
  final bool status;
  const DownloadEvent({
    this.id,
    this.favourite,
    this.status = false
  });

  @override
  List<Object> get props => [];
}

class GetDownloadeds extends DownloadEvent {
  const GetDownloadeds();
}

class GetDownloaded extends DownloadEvent {
  const GetDownloaded({required Favourite favourite})
      : super(favourite: favourite);
}

class CreateDownload extends DownloadEvent {
  const CreateDownload({required Favourite favourite})
      : super(favourite: favourite);
}

class UpdateDownload extends DownloadEvent {
  const UpdateDownload({required Favourite favourite})
      : super(favourite: favourite);
}

class UpdateDownloadStatus extends DownloadEvent {
  const UpdateDownloadStatus({required int id, bool status = false})
      : super(id: id, status: status);
}

class DeleteDownload extends DownloadEvent {
  const DeleteDownload({required int id}) : super(id: id);
}

class DeleteAllDownloaded extends DownloadEvent {
  const DeleteAllDownloaded() : super();
}

