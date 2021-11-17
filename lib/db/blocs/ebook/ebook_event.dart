part of 'ebook_bloc.dart';

abstract class DwonloadedEbookEvent extends Equatable {
  final DownloadedEbook? ebook;
  final int? id;
  final bool status;
  final int? sortOrder;
  const DwonloadedEbookEvent({
    this.id,
    this.sortOrder,
    this.status = false,
    this.ebook,
  });

  @override
  List<Object> get props => [];
}

class GetEbook extends DwonloadedEbookEvent {
  const GetEbook({required DownloadedEbook ebook}) : super(ebook: ebook);
}

class GetDownloadedEbooksEvent extends DwonloadedEbookEvent {
  const GetDownloadedEbooksEvent();
  @override
  List<Object> get props => [];
}

class CreateEbook extends DwonloadedEbookEvent {
  const CreateEbook({required DownloadedEbook ebook}) : super(ebook: ebook);
}

class UpdateEbook extends DwonloadedEbookEvent {
  const UpdateEbook({required DownloadedEbook ebook}) : super(ebook: ebook);
}

class DeleteEbook extends DwonloadedEbookEvent {
  const DeleteEbook({required DownloadedEbook ebook}) : super(ebook: ebook);
}

class DeleteAllEbook extends DwonloadedEbookEvent {
  const DeleteAllEbook() : super();
}
