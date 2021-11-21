import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'ebook_event.dart';
part 'ebook_state.dart';

class EbookBloc extends Bloc<EbookEvent, EbookState> {
  final EbookRespository eBookRespository;
  EbookBloc({required this.eBookRespository}) : super(EbookInitial()) {
    on<GetEbooksEvent>((event, emit) async {
      await _getEbooks(emit);
    });
  }

  Future<void> _getEbooks(Emitter<EbookState> emit) async {
    emit(EbookLoading());
    try {
      final List<Ebook> eBooks = await eBookRespository.fetchEbooks();
      emit(EbookLoaded(eBooks: eBooks));
    } catch (e) {
      emit(EbookError(error: (e.toString())));
    }
  }
}
