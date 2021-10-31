import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/play_button_notifier.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/progress_notifier.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/repeat_button_notifier.dart';
import 'package:thitsarparami/ui/just_audio/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/components/favourite_form.dart';
import 'package:thitsarparami/ui/just_audio/services/components/favourite_list.dart';
import 'package:thitsarparami/widgets/roatate_image.dart';
import 'package:thitsarparami/ui/radio/services/service_locator.dart';
import 'package:thitsarparami/ui/song/components/music_icons.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({Key? key}) : super(key: key);

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animationController.repeat();
  }

  _showModalBottomSheet() {
    const double _radius = 25.0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_radius),
          topRight: Radius.circular(_radius),
        ),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                const FavouriteForm(),
                Divider(
                  color: Theme.of(context).dividerColor,
                ),
                Expanded(
                  child: FavouriteListView(
                    controller: scrollController,
                  ),
                )
              ],
            );
          },
        );
      },
    );
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
                  stops: const [
                    0.0,
                    0.5,
                    0.7,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            // height: screenHeight / 3,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: HideIcon(
                    color: Theme.of(context).iconTheme.color!,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.2,
            height: screenHeight * 0.50,
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
                    const CurrentSongTitle(),
                    const SizedBox(
                      height: 10,
                    ),
                    SocailButtoms(
                      showFavouriteModalBottomSheet: _showModalBottomSheet,
                    ),
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
            height: screenHeight * 0.18,
            child: Container(
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
                Text(
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
                Text(
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
          total: value.total,
          onSeek: playerManager.seek,
          progressBarColor: Theme.of(context).primaryColorDark,
          bufferedBarColor: Theme.of(context).primaryColor,
          baseBarColor: Theme.of(context).primaryColorLight,
          thumbColor: Theme.of(context).primaryColor,
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
          const RepeatButton(),
          const PreviousSongButton(),
          PlayButton(animationController: animationController),
          const NextSongButton(),
          const ShuffleButton(),
        ],
      ),
    );
  }
}

class SocailButtoms extends StatelessWidget {
  final Function showFavouriteModalBottomSheet;
  const SocailButtoms({Key? key, required this.showFavouriteModalBottomSheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FavouriteButton(
            showModalBottomSheet: showFavouriteModalBottomSheet,
          ),
          const DownloadButton(),
          const ShareButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: playerManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = const Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = const Icon(Icons.repeat_one);
            break;
          case RepeatState.repeatPlaylist:
            icon = const Icon(Icons.repeat);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: playerManager.repeat,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: playerManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: (isFirst) ? null : playerManager.previous,
        );
      },
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

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: playerManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: (isLast) ? null : playerManager.next,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: playerManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? const Icon(Icons.shuffle)
              : const Icon(Icons.shuffle, color: Colors.grey),
          onPressed: playerManager.shuffle,
        );
      },
    );
  }
}

class FavouriteButton extends StatelessWidget {
  final Function showModalBottomSheet;
  const FavouriteButton({Key? key, required this.showModalBottomSheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<MediaItem>(
        valueListenable: playerManager.currentSongNotifier,
        builder: (_, song, __) {
          if (song.rating != null) {
            return IconButton(
                icon: song.rating!.hasHeart()
                    ? Icon(
                        Icons.favorite,
                        color: Theme.of(context).primaryColor,
                      )
                    : const Icon(Icons.favorite_outline),
                onPressed: () {
                  song.rating!.hasHeart() ? null : showModalBottomSheet();
                });
          } else {
            return IconButton(
              icon: const Icon(Icons.favorite_outline),
              onPressed: () {
                showModalBottomSheet();
              },
            );
          }
        });
  }
}

class DownloadButton extends StatelessWidget {
  const DownloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.download_outlined),
      onPressed: () {},
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share_outlined),
      onPressed: () {},
    );
  }
}
