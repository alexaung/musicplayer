import 'package:audio_service/audio_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class PlaylistScreen extends StatefulWidget {
  static const routeName = '/playlist';

  final Favourite? favourite;
  const PlaylistScreen({Key? key, this.favourite}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  void initState() {
    super.initState();

    getIt<PlayerManager>().init(PlayerMode.mp3);
    BlocProvider.of<FavouriteSongListBloc>(context)
        .add(GetFavouriteSongs(id: widget.favourite!.id!));
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
  @override
  void initState() {
    super.initState();
    hasQueued = false;

    favouriteSongs = [];
  }

  @override
  void dispose() {
    super.dispose();
    hasQueued = false;
  }

  _onTap(int index, List<FavouriteSong> songs) async {
    final playerManager = getIt<PlayerManager>();

    if (hasQueued == false) {
      final mediaItems = songs
          .map((song) => MediaItem(
                id: song.id.toString(),
                album: song.album,
                title: song.title,
                artist: song.artist,
                artUri: Uri.parse(song.artUrl), //Uri.parse(monk.imageUrl),
                extras: {'url': song.audioUrl},
                rating: song.isFavourite
                    ? const Rating.newHeartRating(true)
                    : const Rating.newHeartRating(false),
              ))
          .toList();
      playerManager.loadPlaylist(mediaItems);
      setState(() {
        hasQueued = true;
      });
      await Future.delayed(const Duration(milliseconds: 100));
    }
    BlocProvider.of<PlayerBloc>(context)
        .add(const IsPlayingEvent(isPlaying: true));

    playerManager.skipToQueueItem(index);
    playerManager.play();
  }

  void _orderChanged(int oldIndex, int newIndex) => setState(
        () {
          if (oldIndex < newIndex) newIndex -= 1;
          final favouriteSong = favouriteSongs.removeAt(oldIndex);
          favouriteSongs.insert(newIndex, favouriteSong);
          favouriteSongs.asMap().forEach(
                (index, song) => {
                  BlocProvider.of<FavouriteSongBloc>(context)
                      .add(UpdateSortOrder(id: song.id!, sortOrder: index + 1))
                },
              );
        },
      );

  void _onDismissed(BuildContext context, index) => setState(
        () {
          FavouriteSong favouriteSong = favouriteSongs[index];
          favouriteSongs.removeAt(index);
          BlocProvider.of<FavouriteSongBloc>(context)
              .add(DeleteFavouriteSong(favouriteSong: favouriteSong));
          // Shows the information on Snackbar
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     content: Text("${favouriteSong.title} ကိုဖျက်လိုက်ပါပြီ။")));

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  AutoSizeText("${favouriteSong.title} ကိုဖျက်လိုက်ပါပြီ။"),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                  label: 'မဖျက်တော့ပါ',
                  onPressed: () {
                    setState(() {
                      favouriteSongs.insert(index, favouriteSong);
                    });

                    BlocProvider.of<FavouriteSongBloc>(context)
                        .add(CreateFavouriteSong(favouriteSong: favouriteSong));
                  }),
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
              child: ReorderableListView.builder(
            onReorder: (int oldIndex, int newIndex) {
              _orderChanged(oldIndex, newIndex);
            },
            itemCount: favouriteSongs.length,
            itemBuilder: (context, index) {
              FavouriteSong song = favouriteSongs[index];
              return Dismissible(
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  _onDismissed(context, index);
                },
                background: Container(color: Colors.red),
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
