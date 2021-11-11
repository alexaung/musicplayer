import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/play_button_notifier.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/progress_notifier.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/widgets/roatate_image.dart';
import 'package:thitsarparami/ui/just_audio/services/player_mode.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';
import 'package:thitsarparami/ui/song/components/music_icons.dart';

class RadioScreen extends StatefulWidget {
  static const routeName = '/radio';
  const RadioScreen({Key? key}) : super(key: key);

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final _itemsView = GlobalKey();
  double _stackHeight = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      RenderBox stackRB =
          _itemsView.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _stackHeight = stackRB.size.height;
      });
    });

    getIt<PlayerManager>().init(PlayerMode.radio);
    //_loadUrl();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
  }

  // _loadUrl() async{
  //   final pageManager = getIt<PlayerManager>();
  //   List<MediaItem> mediaItems = [];
  //   MediaItem mediaItem = const MediaItem(
  //       id: 'radio',
  //       album: 'Radio',
  //       title: 'သစ္စာပါရမီ',
  //       artist: '၂၄ နာရီရေဒီယို',
  //       //artUri: Uri.parse("asset:///assets/images/logo.png"),
  //       extras: {'url': 'https://edge.mixlr.com/channel/nmtev'},
  //       rating: Rating.newHeartRating(false));

  //   mediaItems.add(mediaItem);
  //   pageManager.loadPlaylist(mediaItems);
  // }

  @override
  void dispose() {
    animationController.dispose();
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
            height: screenHeight * 0.4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColorDark,
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorLight,
                  ],
                  stops: const [
                    0.0,
                    0.5,
                    0.7,
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
            top: screenHeight * 0.11 + 75,
            key: _itemsView,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(40)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const AutoSizeText(
                      'သစ္စာပါရမီ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const AutoSizeText(
                      '၂၄ နာရီရေဒီယို',
                      style: TextStyle(
                        fontSize: 18,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    //const CurrentSongTitle(),
                    const SizedBox(
                      height: 10,
                    ),
                    const AudioProgressBar(),
                    AudioControlButtons(
                      animationController: animationController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.11,
            left: (screenWidth - 150) / 2,
            right: (screenWidth - 150) / 2,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Theme.of(context).primaryColorLight, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CurrentSongImage(
                  animationController: animationController,
                ),
              ),
            ),
          ),
          Container(
            height: _stackHeight + (screenHeight * 0.11 + 75 + 25),
          )
        ],
      ),
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<MediaItem>(
      valueListenable: playerManager.currentSongNotifier,
      builder: (_, song, __) {
        return SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  song.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    letterSpacing: 1,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                AutoSizeText(
                  song.artist ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFADB9CD),
                    letterSpacing: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ]),
        );
      },
    );
  }
}

class CurrentSongImage extends StatelessWidget {
  final AnimationController animationController;
  const CurrentSongImage({Key? key, required this.animationController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<MediaItem>(
      valueListenable: playerManager.currentSongNotifier,
      builder: (_, song, __) {
        return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColorDark,
                width: 2,
              ),
            ),
            child: RotateImage(
              animationController: animationController,
              imageUrl: song.artUri == null ? "" : song.artUri.toString(),
            ));
      },
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
          total: const Duration(hours: 24),
          onSeek: playerManager.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  final AnimationController animationController;
  const AudioControlButtons({Key? key, required this.animationController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PlayButton(animationController: animationController),
        ],
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  final AnimationController animationController;
  const PlayButton({Key? key, required this.animationController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: playerManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return CircularProgressIndicatorIcon(
                color: Theme.of(context).iconTheme.color!);
          case ButtonState.paused:
            return GestureDetector(
              onTap: () {
                playerManager.play();
                animationController.repeat();
              },
              child: PlayIcon(
                color: Theme.of(context).iconTheme.color!,
              ),
            );
          case ButtonState.playing:
            return GestureDetector(
              onTap: () {
                playerManager.pause();
                animationController.stop();
              },
              child: PauseIcon(
                color: Theme.of(context).iconTheme.color!,
              ),
            );
        }
      },
    );
  }
}
