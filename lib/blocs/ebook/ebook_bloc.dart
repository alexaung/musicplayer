import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'ebook_event.dart';
part 'ebook_state.dart';

class EbookBloc extends Bloc<EbookEvent, EbookState> {
  final EbookRespository eBookRespository;
  EbookBloc({required this.eBookRespository}) : super(EbookInitial());

  @override
  Stream<EbookState> mapEventToState(EbookEvent event) async* {
    if (event is GetEbooksEvent) {
      yield EbookLoading();
      try {
        final List<Ebook> eBooks = await eBookRespository.fetchEbooks();
        yield EbookLoaded(eBooks: eBooks);
      } catch (e) {
        yield EbookError(error: (e.toString()));
      }
    }
  }
}
