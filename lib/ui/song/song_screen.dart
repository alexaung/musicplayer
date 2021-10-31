import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/error/something_went_wrong.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/play_button_notifier.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/player_mode.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';
import 'package:thitsarparami/ui/song/components/music_icons.dart';
import 'package:thitsarparami/widgets/base_widget.dart';

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
    return BaseWidget(
      child: Scaffold(
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
    BlocProvider.of<PlayerBloc>(context).add(const IsPlayingEvent(isPlaying: true));
  }

  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return BlocBuilder<SongBloc, SongState>(
      builder: (BuildContext context, SongState state) {
        if (state is SongError) {
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
                          Flexible(
                            flex: 2,
                            child: ValueListenableBuilder<String>(
                              valueListenable:
                                  playerManager.currentSongTitleNotifier,
                              builder: (_, title, __) =>
                                  ValueListenableBuilder<ButtonState>(
                                valueListenable:
                                    playerManager.playButtonNotifier,
                                builder: (_, value, __) {
                                  if (title == state.songs[index].title) {
                                    switch (value) {
                                      case ButtonState.loading:
                                        return CircularProgressIndicatorIcon(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color!);
                                      case ButtonState.paused:
                                        return GestureDetector(
                                          onTap: () => _onTap(index),
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
                                      onTap: () => _onTap(index),
                                      child: PlayIcon(
                                        color:
                                            Theme.of(context).iconTheme.color!,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.songs[index].title,
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
                                      Text(
                                        widget.monk!.title,
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
