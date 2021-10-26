import 'package:flutter/material.dart';
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
    _deleteRadioUrl();
    _loadPlayList();
  }

  _deleteRadioUrl() {
    final playerManager = getIt<PlayerManager>();
    playerManager.deleteRadioUrl();
  }

  _loadPlayList() {
    final playerManager = getIt<PlayerManager>();
    playerManager.loadPlaylist(widget.monk!, widget.album!);
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
        children: const [
          Playlist(),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  late int _selectedIndex = -1;

  _onTap(int index) {
    final playerManager = getIt<PlayerManager>();

    setState(() => _selectedIndex = index);
    playerManager.skipToQueueItem(index);
    playerManager.play();
  }

  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: playerManager.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
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
                          ValueListenableBuilder<ButtonState>(
                            valueListenable: playerManager.playButtonNotifier,
                            builder: (_, value, __) {
                              if (_selectedIndex == index) {
                                switch (value) {
                                  case ButtonState.loading:
                                    return Container(
                                      margin: const EdgeInsets.all(8.0),
                                      width: 32.0,
                                      height: 32.0,
                                      child: const CircularProgressIndicator(),
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
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              playlistTitles[index],
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
          );
        },
      ),
    );
  }
}
