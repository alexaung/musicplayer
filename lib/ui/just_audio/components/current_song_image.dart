import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';
import 'package:thitsarparami/widgets/roatate_image.dart';

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