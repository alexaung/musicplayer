part of 'monk_bloc.dart';

abstract class MonkEvent extends Equatable {
  const MonkEvent();
}

class GetMonksEvent extends MonkEvent {
  const GetMonksEvent();

  @override
  List<Object> get props => [];
}
