import 'package:audio_service/audio_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/db/blocs/blocs.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/ui/error/no_result_found.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/play_button_notifier.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/player_mode.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';
import 'package:thitsarparami/ui/song/components/music_icons.dart';
import 'package:thitsarparami/widgets/base_widget.dart';
import 'dart:io';

class FavouritePlayListScreen extends StatefulWidget {
  static const routeName = '/favouritelist';

  final Favourite? favourite;
  const FavouritePlayListScreen({Key? key, this.favourite}) : super(key: key);

  @override
  State<FavouritePlayListScreen> createState() =>
      _FavouritePlayListScreenState();
}

class _FavouritePlayListScreenState extends State<FavouritePlayListScreen> {
  @override
  void initState() {
    super.initState();

    getIt<PlayerManager>().init(PlayerMode.mp3);
    BlocProvider.of<FavouriteSongListBloc>(context)
        .add(GetAllFavouriteSongsByFavouriteId(id: widget.favourite!.id!));
  }

  @override
  void dispose() {
    //getIt<PageManager>().dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: AutoSizeText(
            widget.favourite!.name!,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryIconTheme.color!,
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Playlist(
              favourite: widget.favourite,
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class Playlist extends StatefulWidget {
  final Favourite? favourite;
  const Playlist({Key? key, this.favourite}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  late List<FavouriteSong> favouriteSongs;
  late bool hasQueued;
  late final String path;
  @override
  void initState() {
    super.initState();
    hasQueued = false;
    favouriteSongs = [];
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    path = (await getApplicationDocumentsDirectory()).path;
  }

  @override
  void dispose() {
    super.dispose();
    hasQueued = false;
  }

  _getFilePath(FavouriteSong song) {
    String fileName = song.audioUrl.split("/").last;
    File file = File('$path/mp3/$fileName');
    return file.path;
  }

  _onTap(int index, List<FavouriteSong> songs) async {
    final playerManager = getIt<PlayerManager>();
    playerManager.stop();
    if (hasQueued == false) {
      final mediaItems = songs
          .map((song) => MediaItem(
                id: song.id.toString(),
                album: song.album,
                title: song.title,
                artist: song.artist,
                artUri: Uri.parse(song.artUrl),
                extras: song.isDownloaded
                    ? {
                        'url': _getFilePath(song),
                        'isFavourite': song.isFavourite,
                        'isDownloaded': song.isDownloaded
                      }
                    : {
                        'url': song.audioUrl,
                        'isFavourite': song.isFavourite,
                        'isDownloaded': song.isDownloaded
                      },
                rating: song.isFavourite
                    ? const Rating.newHeartRating(true)
                    : const Rating.newHeartRating(false),
              ))
          .toList();
      await playerManager.loadPlaylist(mediaItems);
      setState(() {
        hasQueued = true;
      });
      BlocProvider.of<PlayerBloc>(context)
          .add(const IsPlayingEvent(isPlaying: true));
      await Future.delayed(const Duration(milliseconds: 100));
    }

    await playerManager.skipToQueueItem(index);
    playerManager.play();
  }

  // void _orderChanged(int oldIndex, int newIndex) => setState(
  //       () {
  //         if (oldIndex < newIndex) newIndex -= 1;
  //         final favouriteSong = favouriteSongs.removeAt(oldIndex);
  //         favouriteSongs.insert(newIndex, favouriteSong);
  //         favouriteSongs.asMap().forEach(
  //               (index, song) => {
  //                 BlocProvider.of<FavouriteSongBloc>(context)
  //                     .add(UpdateSortOrder(id: song.id!, sortOrder: index + 1))
  //               },
  //             );
  //       },
  //     );

  void _onDismissed(BuildContext context, index) => setState(
        () {
          FavouriteSong favouriteSong = favouriteSongs[index];
          favouriteSongs.removeAt(index);
          BlocProvider.of<FavouriteSongBloc>(context)
              .add(DeleteFavouriteSong(favouriteSong: favouriteSong));

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  AutoSizeText("${favouriteSong.title} ကိုဖျက်လိုက်ပါပြီ။"),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: 'မဖျက်တော့ပါ',
                onPressed: () {
                  favouriteSongs.insert(index, favouriteSong);

                  BlocProvider.of<FavouriteSongBloc>(context).add(
                    CreateFavouriteSong(favouriteSong: favouriteSong),
                  );
                },
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return BlocBuilder<FavouriteSongListBloc, FavouriteSongListState>(
      builder: (BuildContext context, FavouriteSongListState state) {
        if (state is SongError) {
          return const SomethingWentWrongScreen();
        } else if (state is FavouriteSongListLoaded) {
          if (state.favouriteSongs.isEmpty) {
            return NoResultFoundScreen(
              title: '${widget.favourite!.name!} folder is empty',
              subTitle: 'Please add your song into playlist.',
            );
          }
          favouriteSongs = state.favouriteSongs;
          return Expanded(
              child: ListView.builder(
            // onReorder: (int oldIndex, int newIndex) {
            //   _orderChanged(oldIndex, newIndex);
            // },
            itemCount: favouriteSongs.length,
            itemBuilder: (context, index) {
              FavouriteSong song = favouriteSongs[index];
              return Dismissible(
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  _onDismissed(context, index);
                },
                background: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.green,
                  child: Icon(
                    Icons.archive_outlined,
                    color: Theme.of(context).appBarTheme.iconTheme!.color,
                    size: 32,
                  ),
                ),
                key: ValueKey(song),
                child: GestureDetector(
                  key: ValueKey(song),
                  onTap: () => _onTap(index, favouriteSongs),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            ValueListenableBuilder<String>(
                              valueListenable:
                                  playerManager.currentSongTitleNotifier,
                              builder: (_, title, __) =>
                                  ValueListenableBuilder<ButtonState>(
                                valueListenable:
                                    playerManager.playButtonNotifier,
                                builder: (_, value, __) {
                                  if (title == song.title) {
                                    switch (value) {
                                      case ButtonState.loading:
                                        return CircularProgressIndicatorIcon(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color!);
                                      case ButtonState.paused:
                                        return GestureDetector(
                                          onTap: () =>
                                              _onTap(index, favouriteSongs),
                                          child: PlayIcon(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color!,
                                          ),
                                        );
                                      case ButtonState.playing:
                                        return GestureDetector(
                                          onTap: playerManager.pause,
                                          child: PauseIcon(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        );
                                    }
                                  } else {
                                    return GestureDetector(
                                      onTap: () =>
                                          _onTap(index, favouriteSongs),
                                      child: PlayIcon(
                                        color:
                                            Theme.of(context).iconTheme.color!,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        song.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Divider(
                                        height: 10,
                                        color: Colors.transparent,
                                      ),
                                      AutoSizeText(
                                        '${song.sortOrder}။ ${song.artist}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFADB9CD),
                                          letterSpacing: 1,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).dividerColor,
                      ),
                    ],
                  ),
                ),
              );
            },
          ));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
