import 'package:audio_service/audio_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/db/blocs/blocs.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';
import 'package:thitsarparami/helper/enum.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';

class FavouriteListView extends StatefulWidget {
  final SocialMode socialMode;
  final ScrollController controller;

  const FavouriteListView(
      {Key? key, required this.controller, required this.socialMode})
      : super(key: key);

  @override
  _FavouriteListViewState createState() => _FavouriteListViewState();
}

class _FavouriteListViewState extends State<FavouriteListView> {
  bool isListItemDisable = false;
  _loadFavourites() async {
    BlocProvider.of<FavouriteBloc>(context).add(const GetFavourites());
  }

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  _onTap(Favourite favourite) async {
    final playerManager = getIt<PlayerManager>();
    MediaItem currentSong = playerManager.currentMediaItem;
    FavouriteSong song = FavouriteSong(
      id: int.parse(currentSong.id),
      favouriteId: favourite.id,
      album: currentSong.album!,
      title: currentSong.title,
      artist: currentSong.artist!,
      artUrl: currentSong.artUri.toString(),
      audioUrl: currentSong.extras!['url'],
      isFavourite: widget.socialMode == SocialMode.favourite ? true : false,
      isDownloaded: widget.socialMode == SocialMode.download ? true : false,
    );
    Favourite newFavourite =
        Favourite(id: favourite.id, name: favourite.name, song: song);

    if (widget.socialMode == SocialMode.favourite) {
      playerManager.setRating(true);

      BlocProvider.of<FavouriteBloc>(context).add(
        AddSongIntoFavourite(favourite: newFavourite),
      );
    } else {
      BlocProvider.of<FavouriteBloc>(context).add(
        DownloadSongIntoFavourite(
          favourite: newFavourite,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavouriteBloc, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteError) {
          isListItemDisable = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: 'ဟုတ်ပြီ',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
          Navigator.of(context).pop();
        } else if (state is Processing) {
          setState(() {
            isListItemDisable = true;
          });
        } else if (state is AddSongInToFavouriteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: 'ဟုတ်ပြီ',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
          Navigator.of(context).pop();
        }
        if (state is DownloadSongInToFavouriteSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (BuildContext context, FavouriteState state) {
          if (state is Error) {
            return const SomethingWentWrongScreen();
          } else if (state is FavouriteListLoaded) {
            return state.favourites.isNotEmpty
                ? ListView.builder(
                    controller: widget.controller,
                    itemCount: state.favourites.length,
                    itemBuilder: (_, int index) {
                      return GestureDetector(
                        onTap: isListItemDisable
                            ? null
                            : () {
                                _onTap(state.favourites[index]);
                              },
                        child: _buildCard(index, state.favourites),
                      );
                    },
                  )
                : const Center(
                    child: AutoSizeText('Empty Playlist'),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildCard(int index, List<Favourite> favourites) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              flex: 2,
              child: FolderIcon(
                color: Theme.of(context).iconTheme.color!,
              ),
            ),
            Flexible(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: AutoSizeText(
                  favourites[index].name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }
}

class FolderIcon extends StatelessWidget {
  final Color color;

  const FolderIcon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //const double _radius = 33;
    return Center(
      child: Icon(
        Icons.folder_special_outlined,
        color: color,
        size: 32.0,
      ),
    );
  }
}
