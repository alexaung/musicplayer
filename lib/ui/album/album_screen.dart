import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/album/components/album_icons.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';
import 'package:thitsarparami/ui/song/song_screen.dart';
import 'package:thitsarparami/widgets/base_widget.dart';

class AlbumScreen extends StatefulWidget {
  static const routeName = '/album';
  final Monk? monk;
  const AlbumScreen({Key? key, this.monk}) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  // List albums = [];
  _loadAlbums() async {
    BlocProvider.of<AlbumBloc>(context).add(const GetAlbumsEvent());
  }

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Monk;

    return BaseWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: AutoSizeText(
            widget.monk!.title,
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
        ),
        body: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (BuildContext context, AlbumState albumState) {
            if (albumState is AlbumError) {
              return const SomethingWentWrongScreen();
            } else if (albumState is AlbumLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      itemCount: albumState.albums.length,
                      itemBuilder: (_, int index) {
                        return GestureDetector(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: SongScreen(
                                monk: widget.monk,
                                album: albumState.albums[index],
                              ),
                            );
                          },
                          child: _listView(index, albumState.albums),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _listView(int index, List<Album> albums) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              AlbumIcon(
                color: Theme.of(context).iconTheme.color!,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          albums[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                        AutoSizeText(
                          widget.monk!.title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFFADB9CD),
                            letterSpacing: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]),
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
    );
  }
}
