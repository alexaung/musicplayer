import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/db/blocs/blocs.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';
import 'package:thitsarparami/ui/just_audio/components/favourite_list.dart';
import 'package:thitsarparami/ui/library/download_screen.dart';
import 'package:thitsarparami/ui/library/favourite_screen.dart';
import 'package:thitsarparami/ui/library/pdf_screen.dart';
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
    BlocProvider.of<FavouriteBloc>(context).add(const GetFavourites());
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
        pageTransitionAnimation: PageTransitionAnimation.scale
      );
    }

    _onDownloadTap() {
      pushNewScreen(
        context,
        screen: const DownloadScreen(),
        pageTransitionAnimation: PageTransitionAnimation.scale
      );
    }

    _onPdfTap() {
      pushNewScreen(
        context,
        screen: const PdfScreen(),
        pageTransitionAnimation: PageTransitionAnimation.scale
      );
    }

    List<CardItem> items = [
      CardItem(
        title: "လက်ရွေးစင် တရားတော်များ",
        color: Theme.of(context).primaryColorDark,
        iconData: Icons.favorite_outlined,
        onTap: _onFavouriteTap,
      ),
      CardItem(
        title: "သိမ်းထားသေား တရားတော်များ",
        color: Theme.of(context).primaryColor,
        iconData: Icons.download_done_outlined,
        onTap: _onDownloadTap,
      ),
      CardItem(
        title: "သိမ်းထားသေား တရားစာအုပ်များ",
        color: Theme.of(context).primaryColorLight,
        iconData: Icons.picture_as_pdf_outlined,
        onTap: _onPdfTap,
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    child: AutoSizeText(
                      'Playlists',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Flexible(child: _buildPlaylist(context)),
                ]),
          )
        ],
      ),
    );
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
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: AutoSizeText(
                cardItem.title,
                style: Theme.of(context).textTheme.headline3,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
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
        pageTransitionAnimation: PageTransitionAnimation.scale
      );
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
                  "အတည်ပြုပါ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            content: const Text(
                "ဤအစီအစဉ်ကို ဖျက်လိုသည်မှာ သေချာပါသလား။ ဤလုပ်ငန်းစဉ်ကို ပြန်ပြင်၍မရပါ။"),
            actions: [
              CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("ဖျက်ပါ")),
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("မဖျက်တော့ပါ"),
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
                label: 'ဟုတ်ပြီ',
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
                label: 'ဟုတ်ပြီ',
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
                    child: AutoSizeText('Empty Playlist'),
                  );
          } else if (state is Processing) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: AutoSizeText("No State"),
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
