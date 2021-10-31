import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/db/blocs/blocs.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/error/something_went_wrong.dart';
import 'package:thitsarparami/ui/just_audio/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';

class FavouriteListView extends StatefulWidget {
  final ScrollController controller;

  const FavouriteListView({Key? key, required this.controller})
      : super(key: key);

  @override
  _FavouriteListViewState createState() => _FavouriteListViewState();
}

class _FavouriteListViewState extends State<FavouriteListView> {
  _loadFavourites() async {
    BlocProvider.of<FavouriteBloc>(context).add(const GetFavourites());
  }

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (BuildContext context, FavouriteState state) {
        if (state is Error) {
          return const SomethingWentWrongScreen();
        } else if (state is ListLoaded) {
          return state.favourites.isNotEmpty
              ? ListView.builder(
                  controller: widget.controller,
                  //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: state.favourites.length,
                  itemBuilder: (_, int index) {
                    return GestureDetector(
                      onTap: () {
                        final playerManager = getIt<PlayerManager>();
                        playerManager.setRating(true);
                        MediaItem currentSong = playerManager.currentMediaItem;
                        FavouriteSong song = FavouriteSong(
                          id: int.parse(currentSong.id),
                          favouriteId: state.favourites[index].id,
                          album: currentSong.album!,
                          title: currentSong.title,
                          artist: currentSong.artist!,
                          artUrl: currentSong.artUri.toString(),
                          audioUrl: currentSong.extras!['url'],
                          isFavourite: true,
                        );
                        BlocProvider.of<FavouriteBloc>(context).add(
                            CreateFavourite(
                                favourite: Favourite(
                                    id: state.favourites[index].id,
                                    name: state.favourites[index].name,
                                    song: song)));
                      },
                      child: _listView(index, state.favourites),
                    );
                  },
                )
              : const Center(
                  child: Text('Empty Playlist'),
                );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _listView(int index, List<Favourite> favourites) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: FolderIcon(
                  color: Theme.of(context).iconTheme.color!,
                ),
              ),
            ),
            Flexible(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
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
