import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/about/about_screen.dart';
import 'package:thitsarparami/ui/address/address_screan.dart';
import 'package:thitsarparami/ui/album/album_screen.dart';
import 'package:thitsarparami/ui/appointment/appointment_screen.dart';
import 'package:thitsarparami/ui/bio/bio_screen.dart';
import 'package:thitsarparami/ui/chanting/chanting_screen.dart';
import 'package:thitsarparami/ui/ebook/ebook_screen.dart';
import 'package:thitsarparami/ui/home/home_screen.dart';
import 'package:thitsarparami/ui/library/library_screen.dart';
import 'package:thitsarparami/ui/library/playlist_screen.dart';
import 'package:thitsarparami/ui/monk/monk_screen.dart';
import 'package:thitsarparami/ui/more/more_screen.dart';
import 'package:thitsarparami/ui/radio/radio_screen.dart';
import 'package:thitsarparami/ui/root/root_screen.dart';
import 'package:thitsarparami/ui/setting/setting_screen.dart';
import 'package:thitsarparami/ui/song/song_screen.dart';
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
  MonkScreen.routeName: (ctx) => const MonkScreen(),
  AlbumScreen.routeName: (ctx) => const AlbumScreen(),
  SongScreen.routeName: (ctx) => const SongScreen(),
  EbookScreen.routeName: (ctx) => const EbookScreen(),
  AppointmentScreen.routeName: (ctx) => const AppointmentScreen(),
  ChantingScreen.routeName: (ctx) => const ChantingScreen(),
  LibraryScreen.routeName: (ctx) => const LibraryScreen(),
  PlaylistScreen.routeName: (ctx) => const PlaylistScreen(),
  BiographyScreen.routeName: (ctx) => const BiographyScreen(),
  //SliverBiographyScreen.routeName: (ctx) => const SliverBiographyScreen(),
  AboutScreen.routeName: (ctx) => const AboutScreen(),
  AddressScreen.routeName: (ctx) => const AddressScreen(),
};
