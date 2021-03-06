import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';
import 'package:thitsarparami/helper/enum.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/album/album_screen.dart';
import 'package:thitsarparami/ui/ebook/ebook_screen.dart';
import 'package:thitsarparami/widgets/base_widget.dart';

class MonkScreen extends StatefulWidget {
  static const routeName = '/monk';
  final String? title;
  final MonkScreenMode? screenMode;
  const MonkScreen({Key? key, this.title, this.screenMode}) : super(key: key);

  @override
  State<MonkScreen> createState() => _MonkScreenState();
}

class _MonkScreenState extends State<MonkScreen> {
  // List monks = [];
  _loadMonks() async {
    BlocProvider.of<MonkBloc>(context).add(const GetMonksEvent());
  }

  @override
  void initState() {
    super.initState();
    _loadMonks();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: AutoSizeText(
            widget.title!,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          leading: IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const RootScreen()),
              // );
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryIconTheme.color!,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: MonkSearch(screenMode: widget.screenMode!));
              },
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryIconTheme.color!,
              ),
            ),
          ],
        ),
        body: BlocBuilder<MonkBloc, MonkState>(
          builder: (BuildContext context, MonkState monkState) {
            if (monkState is MonkError) {
              //final error = monkState.error;
              //String message = '$error\n Tap to Retry.';
              return const SomethingWentWrongScreen();
            } else if (monkState is MonkLoaded) {
              return listViewBuilder(
                  context, monkState.monks, widget.screenMode!);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

Widget listViewBuilder(
    BuildContext context, List<Monk> monks, MonkScreenMode screenMode) {
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          itemCount: monks.length,
          itemBuilder: (_, int index) {
            return GestureDetector(
              onTap: () {
                pushNewScreen(context,
                    screen: MonkScreenMode.album == screenMode
                        ? AlbumScreen(
                            monk: monks[index],
                          )
                        : EbookScreen(
                            monk: monks[index],
                          ),
                    pageTransitionAnimation: PageTransitionAnimation.scale);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: CachedNetworkImage(
                            width: 80.0,
                            height: 80.0,
                            //fit: BoxFit.cover,
                            imageUrl: monks[index].imageUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                Container(color: Colors.black12),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              size: 100,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      monks[index].title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

class MonkSearch extends SearchDelegate<String> {
  final MonkScreenMode screenMode;
  MonkSearch({Key? key, required this.screenMode});

  @override
  String get searchFieldLabel => '??????????????????';
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, '');
            } else {
              query = '';
              showSuggestions(context);
            }
          },
          icon: const Icon(Icons.clear),
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<MonkBloc>(context).add(MonkSearchEvent(query));
    return Container(
      color: Theme.of(context).backgroundColor,
      child: BlocBuilder<MonkBloc, MonkState>(
        builder: (BuildContext context, MonkState monkState) {
          if (monkState is MonkError) {
            //final error = monkState.error;
            //String message = '$error\n Tap to Retry.';
            return const SomethingWentWrongScreen();
          } else if (monkState is MonkLoaded) {
            return listViewBuilder(context, monkState.monks, screenMode);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    BlocProvider.of<MonkBloc>(context).add(MonkSearchEvent(query));
    return Container(
      color: Theme.of(context).backgroundColor,
      child: BlocBuilder<MonkBloc, MonkState>(
        builder: (BuildContext context, MonkState monkState) {
          if (monkState is MonkError) {
            //final error = monkState.error;
            //String message = '$error\n Tap to Retry.';
            return const SomethingWentWrongScreen();
          } else if (monkState is MonkLoaded) {
            return listViewBuilder(context, monkState.monks, screenMode);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
