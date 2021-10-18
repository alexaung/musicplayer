import 'package:flutter_bloc/flutter_bloc.dart';
import '../../settings/theme.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  //
  ThemeBloc()
      : super(
          ThemeState(
            themeData: appThemeData[AppTheme.light]!,
          ),
        );
  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeEvent) {
      yield ThemeState(
        themeData: appThemeData[event.appTheme]!,
      );
    }
  }
}
