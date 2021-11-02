part of 'download_bloc.dart';

abstract class DownloadState extends Equatable {
  const DownloadState();

  @override
  List<Object> get props => [];
}

class DownloadInitial extends DownloadState {}

class Downloading extends DownloadState {}
class DownloadSuccess extends DownloadState {
  final String successMessage;
  const DownloadSuccess({required this.successMessage});
}

class DownloadError extends DownloadState {
  final String error;
  const DownloadError({required this.error});
}
