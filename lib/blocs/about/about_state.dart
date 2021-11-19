part of 'about_bloc.dart';

abstract class AboutState extends Equatable {
  const AboutState();

  @override
  List<Object> get props => [];
}

class AboutInitial extends AboutState {}

class AboutEmpty extends AboutState {}

class AboutLoading extends AboutState {}

class AboutLoaded extends AboutState {
  final About about;
  const AboutLoaded({required this.about});
}

class AboutError extends AboutState {
  final String error;
  const AboutError({required this.error});
}
