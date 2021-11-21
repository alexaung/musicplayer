import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'chanting_event.dart';
part 'chanting_state.dart';

class ChantingBloc extends Bloc<ChantingEvent, ChantingState> {
  final ChantingRespository chantingRespository;
  late List<Chanting> chantings;
  ChantingBloc({required this.chantingRespository}) : super(ChantingInitial()){
    on<GetChantingsEvent>((event, emit) async {
      await _getChantings(emit);
    });
  }

  Future<void> _getChantings(Emitter<ChantingState> emit) async {
    emit(ChantingLoading());
    try {
      final List<Chanting> chantings = await chantingRespository.fetchChantings();
      emit(ChantingLoaded(chantings: chantings));
    } catch (e) {
      emit(ChantingError(error: (e.toString())));
    }
  }
}
