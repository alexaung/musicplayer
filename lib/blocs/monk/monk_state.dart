part of 'monk_bloc.dart';

abstract class MonkState extends Equatable {
  const MonkState();

  @override
  List<Object> get props => [];
}

class MonkEmpty extends MonkState {}

class MonkLoading extends MonkState {}

class MonkInitial extends MonkState {}

class MonkLoaded extends MonkState {
  final List<Monk> monks;
  const MonkLoaded({required this.monks});
}

class MonkError extends MonkState {
  final String error;
  const MonkError({required this.error});
}
