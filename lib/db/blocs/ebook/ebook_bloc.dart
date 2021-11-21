import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';

part 'ebook_event.dart';
part 'ebook_state.dart';

class DownloadedEbookBloc
    extends Bloc<DwonloadedEbookEvent, DownloadedEbookState> {
  final DownloadedEbookRepository ebookRepository;

  DownloadedEbookBloc({required this.ebookRepository}) : super(EbookLoading()) {
    on<GetDownloadedEbooksEvent>((event, emit) async {
      await _getDownloadedEbooks(emit);
    });
    on<GetEbook>((event, emit) async {
      await _getEbook(event.ebook!.id!, emit);
    });

    on<DeleteEbook>((event, emit) async {
      await _deleteEbook(event.ebook!, emit);
    });
  }

  Future<void> _getDownloadedEbooks(Emitter<DownloadedEbookState> emit) async {
    emit(EbookLoading());
    try {
      final List<DownloadedEbook> ebooks = await ebookRepository.fetchEbooks();
      emit(EbooksLoaded(ebooks: ebooks));
    } catch (e) {
      emit(DownloadedEbookError(error: (e.toString())));
    }
  }

  Future<void> _getEbook(int id, Emitter<DownloadedEbookState> emit) async {
    emit(EbookLoading());
    try {
      final DownloadedEbook ebook = await ebookRepository.getEbook(id);
      emit(EbookLoadded(ebook: ebook));
    } catch (e) {
      emit(DownloadedEbookError(error: (e.toString())));
    }
  }

  Future<void> _deleteEbook(
      DownloadedEbook ebook, Emitter<DownloadedEbookState> emit) async {
    emit(EbookLoading());
    try {
      List<DownloadedEbook> ebooks = (state as EbooksLoaded)
          .ebooks
          .where((ebook) => ebook.id != ebook.id)
          .toList();
      await ebookRepository.deleteEbook(ebook.id!);
      emit(EbookSuccess(successMessage: ebook.title + ' have been deleted'));
      emit(EbooksLoaded(ebooks: ebooks));
    } catch (e) {
      emit(DownloadedEbookError(error: (e.toString())));
    }
  }
}
