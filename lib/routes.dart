import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/home/home_screen.dart';
import 'package:thitsarparami/ui/just_audio/my_audio_player.dart';
import 'package:thitsarparami/ui/monk/monk_screen.dart';
import 'package:thitsarparami/ui/more/more_screen.dart';
import 'package:thitsarparami/ui/radio/radio_screen.dart';
import 'package:thitsarparami/ui/root/root_screen.dart';
import 'package:thitsarparami/ui/setting/setting_screen.dart';
import 'package:thitsarparami/ui/youtube/youtube_screen.dart';

final Map<String, WidgetBuilder> routes = {
  RootScreen.routeName: (ctx) => RootScreen(
        menuScreenContext: ctx,
      ),
  HomeScreen.routeName: (ctx) => const HomeScreen(),
  RadioScreen.routeName: (ctx) => const RadioScreen(),
  MoreScreen.routeName: (ctx) => const MoreScreen(),
  SettingScreen.routeName: (ctx) => const SettingScreen(),
  YoutubeScreen.routeName: (ctx) => const YoutubeScreen(),
  MyAudioPlayer.routeName: (ctx) => const MyAudioPlayer(),
  MonkScreen.routeName: (ctx) => const MonkScreen(),
};
