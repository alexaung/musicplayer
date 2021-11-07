part of 'chanting_bloc.dart';

abstract class ChantingEvent extends Equatable {
  const ChantingEvent();
}

class GetChantingsEvent extends ChantingEvent {
  const GetChantingsEvent();
  @override
  List<Object> get props => [];
}
