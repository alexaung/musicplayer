import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/error/something_went_wrong.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/play_button_notifier.dart';
import 'package:thitsarparami/ui/just_audio/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/player_mode.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';

class SongScreen extends StatefulWidget {
  static const routeName = '/song';
  final Monk? monk;
  final Album? album;
  const SongScreen({Key? key, this.monk, this.album}) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  @override
  void initState() {
    super.initState();
    getIt<PlayerManager>().init(PlayerMode.mp3);
    BlocProvider.of<SongBloc>(context).add(GetSongsEvent(id: widget.album!.id));
  }

  @override
  void dispose() {
    //getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          widget.monk!.title,
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Playlist(
            monk: widget.monk,
            album: widget.album,
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class Playlist extends StatefulWidget {
  final Monk? monk;
  final Album? album;
  const Playlist({Key? key, this.monk, this.album}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  _onTap(int index) {
    final playerManager = getIt<PlayerManager>();
    playerManager.skipToQueueItem(index);
    playerManager.play();
  }

  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return BlocBuilder<SongBloc, SongState>(
      builder: (BuildContext context, SongState state) {
        if (state is SongError) {
          // final error = albumState.error;
          // String message = '$error\n Tap to Retry.';
          return const SomethingWentWrongScreen();
        } else if (state is SongLoaded) {
          playerManager.loadPlaylist(widget.monk!, widget.album!, state.songs);
          return Expanded(
              child: ListView.builder(
            itemCount: state.songs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _onTap(index),
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
                              valueListenable: playerManager.playButtonNotifier,
                              builder: (_, value, __) {
                                if (title == state.songs[index].title) {
                                  switch (value) {
                                    case ButtonState.loading:
                                      return Container(
                                        margin: const EdgeInsets.all(8.0),
                                        width: 32.0,
                                        height: 32.0,
                                        child:
                                            const CircularProgressIndicator(),
                                      );
                                    case ButtonState.paused:
                                      return IconButton(
                                        icon: const Icon(Icons.play_arrow),
                                        iconSize: 32.0,
                                        onPressed: () => _onTap(index),
                                      );
                                    case ButtonState.playing:
                                      return IconButton(
                                        icon: const Icon(Icons.pause),
                                        iconSize: 32.0,
                                        onPressed: playerManager.pause,
                                      );
                                  }
                                } else {
                                  return IconButton(
                                    icon: const Icon(Icons.play_arrow),
                                    iconSize: 32.0,
                                    onPressed: () => _onTap(index),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              state.songs[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
