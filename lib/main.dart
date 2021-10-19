import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/settings/preferences.dart';
import 'package:thitsarparami/ui/home/home_screen.dart';
import 'package:thitsarparami/blocs/theme/theme_bloc.dart';
import 'package:thitsarparami/blocs/theme/theme_state.dart';
import 'package:thitsarparami/ui/more/more_screen.dart';
import 'package:thitsarparami/ui/root/root_screen.dart';
import 'package:thitsarparami/ui/setting/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
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

    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: themeState.themeData,
            //home: const RootScreen(),
            initialRoute: '/',
            routes: {
              RootScreen.routeName: (ctx) => const RootScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              MoreScreen.routeName: (ctx) => const MoreScreen(),
              SettingScreen.routeName: (ctx) => const SettingScreen(),
            },
          );
        },
      ),
    );
  }
}
