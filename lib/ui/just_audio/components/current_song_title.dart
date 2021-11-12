import 'package:audio_service/audio_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/player_mode.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';

class CurrentSongTitle extends StatelessWidget {
  final double titleFontSize;
  final double subTitleFontSize;
  const CurrentSongTitle({Key? key, this.titleFontSize = 20, this.subTitleFontSize = 18})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<PlayerMode>(
      valueListenable: playerManager.playeModeNotifier,
      builder: (_, mode, __) {
        if (mode == PlayerMode.radio) {
          return const RadioTitle();
        } else {
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
                          fontSize: titleFontSize,
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
                        style:  TextStyle(
                          fontSize: subTitleFontSize,
                          color: const Color(0xFFADB9CD),
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
      },
    );
  }
}

class RadioTitle extends StatelessWidget {
  const RadioTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: const [
          AutoSizeText(
            'သစ္စာပါရမီ',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          AutoSizeText(
            '၂၄ နာရီရေဒီယို',
            style: TextStyle(
              fontSize: 18,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
