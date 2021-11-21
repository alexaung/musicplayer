import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  final AboutRespository aboutRespository;
  late About about;
  AboutBloc({required this.aboutRespository}) : super(AboutInitial()) {
    on<GetAboutEvent>((event, emit) async {
      await _getAbout(emit);
    });
  }

  Future<void> _getAbout(Emitter<AboutState> emit) async {
    emit(AboutLoading());
    try {
      final About about = await aboutRespository.fetchAbout();
      emit(AboutLoaded(about: about));
    } catch (e) {
      emit(AboutError(error: (e.toString())));
    }
  }
}
