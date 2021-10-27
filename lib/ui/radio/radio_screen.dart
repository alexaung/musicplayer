import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/play_button_notifier.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/progress_notifier.dart';
import 'package:thitsarparami/ui/just_audio/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/player_mode.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';

class RadioScreen extends StatefulWidget {
  static const routeName = '/radio';
  const RadioScreen({Key? key}) : super(key: key);

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  @override
  void initState() {
    super.initState();
    getIt<PlayerManager>().init(PlayerMode.radio);
    _loadUrl();
  }

  _loadUrl() {
    final pageManager = getIt<PlayerManager>();
    pageManager.addRadioUrl('https://edge.mixlr.com/channel/nmtev');
  }

  @override
  void dispose() {
    //getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColorDark,
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorLight,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            // height: screenHeight / 3,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  // advancedPlayer.stop();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.2,
            height: screenHeight * 0.36,
            
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(40)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    const Text(
                      'THITSARPARAMI',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '24 Hours Radio',
                      style: TextStyle(
                        fontSize: 18,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    // AudioFile(
                    //   advancedPlayer: advancedPlayer,
                    //   audioPath: 'https://edge.mixlr.com/channel/nmtev',
                    // )
                    // const Expanded(child: Playlist()),
                    const AudioProgressBar(),
                    const AudioControlButtons(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.12,
            left: (screenWidth - 150) / 2,
            right: (screenWidth - 150) / 2,
            height: screenHeight * 0.16,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Theme.of(context).primaryColorLight, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
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
              return ListTile(
                title: Text(playlistTitles[index]),
              );
            },
          );
        },
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: playerManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: playerManager.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          //RepeatButton(),
          //PreviousSongButton(),
          PlayButton(),
          //NextSongButton(),
          //ShuffleButton(),
        ],
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: playerManager.playButtonNotifier,
      builder: (_, value, __) {
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
              onPressed: playerManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: const Icon(Icons.pause),
              iconSize: 32.0,
              onPressed: playerManager.pause,
            );
        }
      },
    );
  }
}
