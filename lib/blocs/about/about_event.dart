part of 'about_bloc.dart';

abstract class AboutEvent extends Equatable {
  const AboutEvent();
}

class GetAboutEvent extends AboutEvent {
  const GetAboutEvent();
  @override
  List<Object> get props => [];
}
