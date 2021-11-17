import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';

part 'ebook_event.dart';
part 'ebook_state.dart';

class DownloadedEbookBloc
    extends Bloc<DwonloadedEbookEvent, DownloadedEbookState> {
  final DownloadedEbookRepository ebookRepository;

  DownloadedEbookBloc({required this.ebookRepository}) : super(EbookLoading());

  @override
  Stream<DownloadedEbookState> mapEventToState(
      DwonloadedEbookEvent event) async* {
    //yield EbookLoading();
    if (event is GetDownloadedEbooksEvent) {
      try {
        final List<DownloadedEbook> ebooks = await ebookRepository.fetchEbooks();
        yield EbooksLoaded(ebooks: ebooks);
      } catch (e) {
        yield DownloadedEbookError(error: (e.toString()));
      }
    } else if (event is GetEbook) {
      try {
        final DownloadedEbook ebook = await ebookRepository.getEbook(event.ebook!.id!);
        yield EbookLoadded(ebook: ebook);
      } catch (e) {
        yield DownloadedEbookError(error: (e.toString()));
      }
    } else if (event is CreateEbook) {
      try {
        await ebookRepository.insertEbook(event.ebook!);
        yield EbookSuccess(successMessage: event.ebook!.title + ' created');
      } catch (e) {
        yield DownloadedEbookError(error: (e.toString()));
      }
    } else if (event is UpdateEbook) {
      try {
        await ebookRepository.updateEbook(event.ebook!);
        yield EbookSuccess(successMessage: event.ebook!.title + ' updated');
      } catch (e) {
        yield DownloadedEbookError(error: (e.toString()));
      }
    } else if (event is DeleteEbook) {
      try {
        List<DownloadedEbook> ebooks = (state as EbooksLoaded)
            .ebooks
            .where((ebook) => ebook.id != event.ebook!.id)
            .toList();
        await ebookRepository.deleteEbook(event.ebook!.id!);
        yield EbookSuccess(
            successMessage: event.ebook!.title + ' have been deleted');
            yield EbooksLoaded(ebooks: ebooks);
      } catch (e) {
        yield DownloadedEbookError(error: (e.toString()));
      }
    } else if (event is DeleteAllEbook) {
      try {
        await ebookRepository.deleteAllEbooks();
        yield const EbookSuccess(
            successMessage: "All Ebooks have been deleted");
      } catch (e) {
        yield DownloadedEbookError(error: (e.toString()));
      }
    }
  }
}
