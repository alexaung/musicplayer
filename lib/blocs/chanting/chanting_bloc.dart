import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'chanting_event.dart';
part 'chanting_state.dart';

class ChantingBloc extends Bloc<ChantingEvent, ChantingState> {
  final ChantingRespository chantingRespository;
  late List<Chanting> chantings;
  ChantingBloc({required this.chantingRespository}) : super(ChantingInitial());

  @override
  Stream<ChantingState> mapEventToState(ChantingEvent event) async* {
    if (event is GetChantingsEvent) {
      yield ChantingLoading();
      try {
        final List<Chanting> chantings = await chantingRespository.fetchChantings();
        yield ChantingLoaded(chantings: chantings);
      } catch (e) {
        yield ChantingError(error: (e.toString()));
      }
    }
  }
}
