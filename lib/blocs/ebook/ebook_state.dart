part of 'ebook_bloc.dart';

abstract class EbookState extends Equatable {
  const EbookState();

  @override
  List<Object> get props => [];
}

class EbookInitial extends EbookState {}

class EbookEmpty extends EbookState {}

class EbookLoading extends EbookState {}

class EbookLoaded extends EbookState {
  final List<Ebook> eBooks;
  const EbookLoaded({required this.eBooks});
}

class EbookError extends EbookState {
  final String error;
  const EbookError({required this.error});
}
