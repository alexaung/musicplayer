import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/db/blocs/blocs.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/ui/error/no_result_found.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';
import 'package:thitsarparami/ui/just_audio/components/favourite_list.dart';
import 'package:thitsarparami/ui/library/playlist_screen.dart';

class DownloadScreen extends StatefulWidget {
  static const routeName = '/download';

  const DownloadScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: AutoSizeText(
          "Downloaded",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryIconTheme.color!,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: _buildPlaylist(context)),
                ]),
          )
        ],
      ),
    );
  }

  Widget _buildPlaylist(BuildContext context) {
    _onTap(Favourite favourite) {
      pushNewScreen(context,
          screen: PlaylistScreen(
            favourite: favourite,
          ),
          pageTransitionAnimation: PageTransitionAnimation.scale);
    }

    void _onDismissed(BuildContext context, Favourite favourite) => {
          BlocProvider.of<FavouriteBloc>(context).add(
            DeleteAllSongsByFavouriteId(favourite: favourite),
          )
        };

    Future<bool?> _confirmDismiss() async {
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  "???????????????????????????",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            content: const Text(
                "????????????????????????????????? ??????????????????????????????????????? ???????????????????????????????????? ????????????????????????????????????????????? ??????????????????????????????????????????"),
            actions: [
              CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("??????????????????")),
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("?????????????????????????????????"),
              ),
            ],
          );
        },
      );
    }

    return BlocListener<FavouriteBloc, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: AutoSizeText(state.error),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: '?????????????????????',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        } else if (state is DeleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: '?????????????????????',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        }
      },
      child: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (BuildContext context, FavouriteState state) {
          if (state is Error) {
            return const SomethingWentWrongScreen();
          } else if (state is FavouriteListLoaded) {
            return state.favourites.isNotEmpty
                ? ListView.separated(
                    itemCount: state.favourites.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 1),
                    itemBuilder: (_, int index) {
                      return Dismissible(
                        direction: DismissDirection.startToEnd,
                        confirmDismiss: (direction) async {
                          return _confirmDismiss();
                        },
                        onDismissed: (direction) {
                          _onDismissed(context, state.favourites[index]);
                        },
                        background: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.green,
                          child: Icon(
                            Icons.archive_outlined,
                            color:
                                Theme.of(context).appBarTheme.iconTheme!.color,
                            size: 32,
                          ),
                        ),
                        key: ValueKey(state.favourites[index]),
                        child: GestureDetector(
                          onTap: () {
                            _onTap(state.favourites[index]);
                          },
                          child: _buildCard(
                              context, state.favourites[index], _onTap),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: NoResultFoundScreen(
                      title: 'Folder is empty',
                      subTitle: 'Please add your song into playlist.',
                    ),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, Favourite favourite, Function onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    onTap();
                  },
                  child: FolderIcon(
                    color: Theme.of(context).iconTheme.color!,
                  ),
                ),
              ),
              Flexible(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: AutoSizeText(
                    favourite.name!,
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
        ),
      ],
    );
  }
}
