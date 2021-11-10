import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/db/blocs/blocs.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';
import 'package:thitsarparami/ui/just_audio/components/favourite_list.dart';
import 'package:thitsarparami/ui/library/favourite_screen.dart';
import 'package:thitsarparami/ui/library/playlist_screen.dart';

class LibraryScreen extends StatefulWidget {
  static const routeName = '/library';
  final BuildContext? menuScreenContext;
  final PersistentTabController? tabController;
  final Function? onScreenHideButtonPressed;
  final bool hideStatus;
  const LibraryScreen(
      {Key? key,
      this.menuScreenContext,
      this.tabController,
      this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class CardItem {
  String title;
  Color color;
  IconData iconData;
  Function onTap;
  CardItem({
    Key? key,
    required this.title,
    required this.color,
    required this.iconData,
    required this.onTap,
  });
}

class _LibraryScreenState extends State<LibraryScreen> {
  _loadFavourites() async {
    BlocProvider.of<FavouriteListBloc>(context).add(const GetFavourites());
  }

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    _onFavouriteTap() {
      pushNewScreen(
        context,
        screen: const FavouriteScreen(),
      );
    }

    _onDownloadTap() {
      pushNewScreen(
        context,
        screen: const FavouriteScreen(),
      );
    }

    _onPdfTap() {
      pushNewScreen(
        context,
        screen: const FavouriteScreen(),
      );
    }

    List<CardItem> items = [
      CardItem(
        title: "Favourites",
        color: Theme.of(context).primaryColorDark,
        iconData: Icons.favorite_outlined,
        onTap: _onFavouriteTap,
      ),
      CardItem(
        title: "Downloaded",
        color: Theme.of(context).primaryColor,
        iconData: Icons.download_done_outlined,
        onTap: _onDownloadTap,
      ),
      CardItem(
        title: "PDF",
        color: Theme.of(context).primaryColorLight,
        iconData: Icons.picture_as_pdf_outlined,
        onTap: _onPdfTap,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: AutoSizeText(
          "Libraries",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            widget.tabController!.jumpToTab(0);
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
                  _topMenu(items),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Flexible(
                      child: AutoSizeText(
                        'Playlists',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                  Flexible(child: _buildPlaylist(context))
                ]),
          )
        ],
      ),
    );
  }
}

Widget _topMenu(List<CardItem> items) {
  return SizedBox(
    height: 120,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (items.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return buildCard(context, items[index]);
        }
      },
      separatorBuilder: (context, _) => const SizedBox(
        width: 10,
      ),
      itemCount: items.length,
    ),
  );
}

Widget buildCard(BuildContext context, CardItem cardItem) {
  const double _radius = 55;
  return GestureDetector(
    onTap: () {
      cardItem.onTap();
    },
    child: Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      width: 130,
      height: 130,
      color: cardItem.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: _radius,
            height: _radius,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: cardItem.color,
              ),
              borderRadius: BorderRadius.circular(
                _radius,
              ),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  cardItem.onTap();
                },
                icon: Icon(
                  cardItem.iconData,
                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                  size: 32.0,
                ),
              ),
            ),
          ),
          AutoSizeText(
            cardItem.title,
            style: Theme.of(context).textTheme.headline2,
            maxLines: 1,
          ),
        ],
      ),
    ),
  );
}

Widget _buildPlaylist(BuildContext context) {
  _onTap(Favourite favourite) {
    pushNewScreen(
      context,
      screen: PlaylistScreen(
        favourite: favourite,
      ),
    );
  }

  return BlocBuilder<FavouriteListBloc, FavouriteListState>(
    builder: (BuildContext context, FavouriteListState state) {
      if (state is Error) {
        return const SomethingWentWrongScreen();
      } else if (state is FavouriteListLoaded) {
        return state.favourites.isNotEmpty
            ? ListView.builder(
                itemCount: state.favourites.length,
                itemBuilder: (_, int index) {
                  return GestureDetector(
                    onTap: () {
                      _onTap(state.favourites[index]);
                    },
                    child: _buildCard(context, state.favourites[index], _onTap),
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
  );
}

Widget _buildCard(BuildContext context, Favourite favourite, Function onTap) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
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
      Divider(
        color: Theme.of(context).dividerColor,
      ),
    ],
  );
}
