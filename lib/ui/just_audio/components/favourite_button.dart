import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/db/blocs/blocs.dart';
import 'package:thitsarparami/helper/enum.dart';
import 'package:thitsarparami/ui/just_audio/components/favourite_form.dart';
import 'package:thitsarparami/ui/just_audio/components/favourite_list.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({Key? key}) : super(key: key);

  _showModalBottomSheet(BuildContext context) {
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
                const FavouriteForm(
                  socialMode: SocialMode.favourite,
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                ),
                Expanded(
                  child: FavouriteListView(
                    socialMode: SocialMode.download,
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
    _unFavourite() {
      final playerManager = getIt<PlayerManager>();
      playerManager.setRating(false);
      MediaItem currentSong = playerManager.currentMediaItem;

      BlocProvider.of<FavouriteBloc>(context).add(
        UpdateFavouriteStatus(
          id: int.parse(currentSong.id),
          status: false,
        ),
      );
    }

    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<MediaItem>(
      valueListenable: playerManager.currentSongNotifier,
      builder: (_, song, __) {
        if (song.rating!.hasHeart()) {
          return IconButton(
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                _unFavourite();
              });
        } else {
          return IconButton(
            icon: const Icon(Icons.favorite_outline),
            onPressed: () {
              _showModalBottomSheet(context);
            },
          );
        }
      },
    );
  }
}