part of 'ebook_bloc.dart';

abstract class DownloadedEbookState extends Equatable {
  const DownloadedEbookState();

  @override
  List<Object> get props => [];
}

class EbookInitial extends DownloadedEbookState {}

class EbookLoading extends DownloadedEbookState {}

class EbooksLoaded extends DownloadedEbookState {
  final List<DownloadedEbook> ebooks;
  const EbooksLoaded({required this.ebooks});
}

class EbookLoadded extends DownloadedEbookState {
  final DownloadedEbook ebook;
  const EbookLoadded({required this.ebook});
}



class EbookSuccess extends DownloadedEbookState {
  final String successMessage;
  const EbookSuccess({required this.successMessage});
}

class DownloadedEbookError extends DownloadedEbookState {
  final String error;
  const DownloadedEbookError({required this.error});
}
