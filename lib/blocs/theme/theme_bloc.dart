import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../settings/theme.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          ThemeState(
            themeData: AppThemes.appThemeData[AppTheme.light]!,
          ),
        ) {
    on<ThemeEvent>((event, emit) => _setTheme(event.appTheme!, emit));
  }

  // @override
  // Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
  //   if (event is ThemeEvent) {
  //     yield ThemeState(
  //       themeData: AppThemes.appThemeData[event.appTheme]!,
  //     );
  //   }
  // }

  Stream<ThemeState> _setTheme(
      AppTheme appTheme, Emitter<ThemeState> emit) async* {
    yield ThemeState(
      themeData: AppThemes.appThemeData[appTheme]!,
    );
  }
}
