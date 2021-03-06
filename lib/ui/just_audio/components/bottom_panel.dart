import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/ui/just_audio/components/audio_progress_bar.dart';
import 'package:thitsarparami/ui/just_audio/components/current_song_title.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/play_button_notifier.dart';
import 'package:thitsarparami/ui/just_audio/now_playing_screen.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';
import 'package:thitsarparami/ui/song/components/music_icons.dart';

class BottomPanel extends StatefulWidget {
  //final PanelController controller;
  const BottomPanel({Key? key}) : super(key: key);

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
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
          initialChildSize: 1,
          expand: false,
          builder: (context, scrollController) {
            return NowPlayingScreen(
              controller: scrollController,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double _radius = 25.0;
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (BuildContext context, PlayerState playerState) {
        if (playerState is Playing) {
          return Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(_radius),
                topRight: Radius.circular(_radius),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColorLight.withOpacity(0.4),
                  spreadRadius: 8,
                  blurRadius: 5,
                  offset: const Offset(0, 7), // changes position of shadow
                ),
              ],
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   stops: [
              //     0.0,
              //     0.7,
              //   ],
              //   colors: [
              //     //Theme.of(context).primaryColorDark,
              //     Theme.of(context).primaryColor,
              //     Theme.of(context).primaryColorLight,
              //   ],
              // ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const AudioControlButtons(),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _showModalBottomSheet();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: CurrentSongTitle(titleFontSize: 16, subTitleFontSize: 14,),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: ShowIcon(
                          color: Theme.of(context).iconTheme.color!,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                        ),
                      ),
                      const Flexible(
                        flex: 10,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: AudioProgressBar(timeLabelLocation: TimeLabelLocation.none,),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
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
          PlayButton(),
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
            return CircularProgressIndicatorIcon(
                color: Theme.of(context).iconTheme.color!);
          case ButtonState.paused:
            return GestureDetector(
              onTap: playerManager.play,
              child: PlayIcon(
                color: Theme.of(context).iconTheme.color!,
              ),
            );
          case ButtonState.playing:
            return GestureDetector(
              onTap: playerManager.pause,
              child: PauseIcon(
                color: Theme.of(context).iconTheme.color!,
              ),
            );
        }
      },
    );
  }
}
