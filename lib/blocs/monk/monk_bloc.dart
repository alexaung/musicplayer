
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
    if (event is GetMonksEvent) {
      yield MonkLoading();
      try {
        final List<Monk> monks = await monkRespository.fetchMonks();
        yield MonkLoaded(monks: monks);
      } catch (e) {
        yield MonkError(error: (e.toString()));
      }
    }
  }
}
