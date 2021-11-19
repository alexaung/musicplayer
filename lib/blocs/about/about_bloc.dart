import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  final AboutRespository aboutRespository;
  late About about;
  AboutBloc({required this.aboutRespository}) : super(AboutInitial());

  @override
  Stream<AboutState> mapEventToState(AboutEvent event) async* {
    if (event is GetAboutEvent) {
      yield AboutLoading();
      try {
        final About about = await aboutRespository.fetchAbout();
        yield AboutLoaded(about: about);
      } catch (e) {
        yield AboutError(error: (e.toString()));
      }
    }
  }
}
