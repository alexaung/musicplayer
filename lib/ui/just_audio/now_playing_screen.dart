import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/just_audio/components/audio_control_button/next_song_button.dart';
import 'package:thitsarparami/ui/just_audio/components/audio_control_button/play_button.dart';
import 'package:thitsarparami/ui/just_audio/components/audio_control_button/previous_song_button.dart';
import 'package:thitsarparami/ui/just_audio/components/audio_control_button/repeat_button.dart';
import 'package:thitsarparami/ui/just_audio/components/audio_control_button/shuffle_button.dart';
import 'package:thitsarparami/ui/just_audio/components/audio_progress_bar.dart';
import 'package:thitsarparami/ui/just_audio/components/current_song_image.dart';
import 'package:thitsarparami/ui/just_audio/components/current_song_title.dart';
import 'package:thitsarparami/ui/just_audio/components/download_button.dart';
import 'package:thitsarparami/ui/just_audio/components/favourite_button.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/player_mode.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';
import 'package:thitsarparami/ui/song/components/music_icons.dart';

class NowPlayingScreen extends StatefulWidget {
  final ScrollController? controller;
  final BuildContext? menuScreenContext;
  final Function? onScreenHideButtonPressed;
  final bool hideStatus;
  final bool hideCloseButton;
  const NowPlayingScreen({
    Key? key,
    this.menuScreenContext,
    this.onScreenHideButtonPressed,
    this.hideStatus = false,
    this.hideCloseButton = false,
    this.controller,
  }) : super(key: key);

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen>
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
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    
  }

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
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        controller: widget.controller,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight * 0.5,
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
                    child: widget.hideCloseButton
                        ? null
                        : HideIcon(
                            color: Theme.of(context).iconTheme.color!,
                          ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.11 + 75,
              //height: screenHeight,
              key: _itemsView,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(40)),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      const CurrentSongTitle(),
                      const SizedBox(
                        height: 10,
                      ),
                      const SocailButtoms(),
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
      ),
    );
  }
}



class AudioControlButtons extends StatelessWidget {
  final AnimationController animationController;
  const AudioControlButtons({Key? key, required this.animationController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<PlayerMode>(
        valueListenable: playerManager.playeModeNotifier,
        builder: (_, mode, __) {
          if (mode == PlayerMode.radio) {
            return SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PlayButton(animationController: animationController),
                ],
              ),
            );
          } else {
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
        });
  }
}

class SocailButtoms extends StatelessWidget {
  const SocailButtoms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<PlayerMode>(
        valueListenable: playerManager.playeModeNotifier,
        builder: (_, mode, __) {
          if (mode == PlayerMode.radio) {
            return const SizedBox(
              height: 0,
            );
          } else {
            return SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  FavouriteButton(),
                  DownloadButton(),
                  ShareButton(),
                ],
              ),
            );
          }
        });
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
