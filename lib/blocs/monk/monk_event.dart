part of 'monk_bloc.dart';

abstract class MonkEvent extends Equatable {
  const MonkEvent();
}

class GetMonksEvent extends MonkEvent {
  const GetMonksEvent();

  @override
  List<Object> get props => [];
}

class MonkSearchEvent extends MonkEvent {
  final String query;
  const MonkSearchEvent(this.query);

  @override
  List<Object> get props => [];
}
