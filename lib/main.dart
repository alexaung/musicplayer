import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/db/blocs/blocs.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';
import 'package:thitsarparami/repositories/repositories.dart';
import 'package:thitsarparami/routes.dart';
import 'package:thitsarparami/services/services.dart';
import 'package:thitsarparami/settings/preferences.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await setupServiceLocator();
  await FlutterDownloader.initialize(debug: true);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) =>
              MonkBloc(monkRespository: MonkRespository(MonkApiProvider())),
        ),
        BlocProvider(
          create: (context) =>
              AlbumBloc(albumRespository: AlbumRespository(AlbumApiProvider())),
        ),
        BlocProvider(
          create: (context) =>
              SongBloc(songRespository: SongRespository(SongApiProvider())),
        ),
        BlocProvider(
          create: (context) =>
              EbookBloc(eBookRespository: EbookRespository(EbookApiProvider())),
        ),
        BlocProvider(
          create: (context) => ChantingBloc(
              chantingRespository: ChantingRespository(ChantingApiProvider())),
        ),
        BlocProvider(
          create: (context) => AppointmentBloc(
              appointmentRespository:
                  AppointmentRespository(AppointmentApiProvider())),
        ),
        BlocProvider(
          create: (context) => PlayerBloc(),
        ),
        BlocProvider(
          create: (context) =>
              FavouriteBloc(favouriteRepository: FavouriteRepository()),
        ),
        
        BlocProvider(
          create: (context) => FavouriteSongListBloc(
              favouriteSongRespository: FavouriteSongRepository()),
        ),
        BlocProvider(
          create: (context) => FavouriteSongBloc(
              favouriteSongRepository: FavouriteSongRepository()),
        ),
        BlocProvider(
          create: (context) => DownloadedEbookBloc(
              ebookRepository: DownloadedEbookRepository()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState themeState) {
          initializeDateFormatting('my_MM');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Thitsarparami',
            theme: themeState.themeData,
            // home: const HomeScreen(),
            initialRoute: '/',
            routes: routes,
          );
        },
      ),
    );
  }
}
