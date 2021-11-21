import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/monk_respository.dart';

part 'monk_event.dart';
part 'monk_state.dart';

class MonkBloc extends Bloc<MonkEvent, MonkState> {
  final MonkRespository monkRespository;
  late List<Monk> monks;

  MonkBloc({required this.monkRespository}) : super(MonkInitial()) {
    on<GetMonksEvent>((event, emit) async {
      await _getMonks(emit);
    });
    on<MonkSearchEvent>((event, emit) async {
      await _searchMonks(event.query, emit);
    });
  }

  Future<void> _getMonks(Emitter<MonkState> emit) async {
    emit(MonkLoading());
    try {
      final List<Monk> monks = await monkRespository.fetchMonks();
      emit(MonkLoaded(monks: monks));
    } catch (e) {
      emit (MonkError(error: (e.toString())));
    }
  }

  Future<void> _searchMonks(String query, Emitter<MonkState> emit) async {
    emit(MonkLoading());
    try {
      final List<Monk> monks = await monkRespository.searchMonks(query);
      emit(MonkLoaded(monks: monks));
    } catch (e) {
      emit(MonkError(error: (e.toString())));
    }
  }
}
