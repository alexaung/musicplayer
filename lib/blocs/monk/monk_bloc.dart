import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/monk_respository.dart';

part 'monk_event.dart';
part 'monk_state.dart';

class MonkBloc extends Bloc<MonkEvent, MonkState> {
  final MonkRespository monkRespository;
  late List<Monk> monks;

  MonkBloc({required this.monkRespository}) : super(MonkInitial());

  @override
  Stream<MonkState> mapEventToState(MonkEvent event) async* {
    yield MonkLoading();
    if (event is GetMonksEvent) {
      try {
        final List<Monk> monks = await monkRespository.fetchMonks();
        yield MonkLoaded(monks: monks);
      } catch (e) {
        yield MonkError(error: (e.toString()));
      }
    }
    if (event is MonkSearchEvent) {
      try {
        final List<Monk> monks = await monkRespository.searchMonks(event.query);
        yield MonkLoaded(monks: monks);
      } catch (e) {
        yield MonkError(error: (e.toString()));
      }
    }
  }
}
