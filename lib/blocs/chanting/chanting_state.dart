part of 'chanting_bloc.dart';

abstract class ChantingState extends Equatable {
  const ChantingState();

  @override
  List<Object> get props => [];
}

class ChantingInitial extends ChantingState {}

class ChantingEmpty extends ChantingState {}

class ChantingLoading extends ChantingState {}

class ChantingLoaded extends ChantingState {
  final List<Chanting> chantings;
  const ChantingLoaded({required this.chantings});
}

class ChantingError extends ChantingState {
  final String error;
  const ChantingError({required this.error});
}
