import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/repositories/repositories.dart';
import 'package:thitsarparami/routes.dart';
import 'package:thitsarparami/services/services.dart';
import 'package:thitsarparami/settings/preferences.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => MonkBloc(monkRespository: MonkRespository(MonkApiProvider())),
        ),
        BlocProvider(
          create: (context) => AlbumBloc(albumRespository: AlbumRespository(AlbumApiProvider())),
        ),
        BlocProvider(
          create: (context) => SongBloc(songRespository: SongRespository(SongApiProvider())),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: themeState.themeData,
            //home: const RootScreen(),
            initialRoute: '/',
            routes: routes,
          );
        },
      ),
    );
  }
}
