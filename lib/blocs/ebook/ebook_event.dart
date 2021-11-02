part of 'ebook_bloc.dart';

abstract class EbookEvent extends Equatable {
  const EbookEvent();
}

class GetEbooksEvent extends EbookEvent {
  const GetEbooksEvent();
  @override
  List<Object> get props => [];
}
