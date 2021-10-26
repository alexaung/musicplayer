import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/error/something_went_wrong.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/song/song_screen.dart';

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

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
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
            // final error = albumState.error;
            // String message = '$error\n Tap to Retry.';
            return const SomethingWentWrongScreen();
          } else if (albumState is AlbumLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
    );
  }

  Widget _listView(int index, List<Album> albums) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            // Container(
            //   width: 80,
            //   height: 80,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     image: DecorationImage(
            //         image: NetworkImage(albums[index].imageUrl),
            //         fit: BoxFit.cover),
            //   ),
            // ),
            Icon(
              Icons.album_outlined,
              size: 60,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                albums[index].title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        // const SizedBox(
        //   height: 15,
        // ),
        Divider(
          color: Theme.of(context).dividerColor,
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10),
        //   child: Row(
        //     children: [
        //       // Container(
        //       //   width: 80,
        //       //   height: 20,
        //       //   decoration: BoxDecoration(
        //       //     color: Theme.of(context).scaffoldBackgroundColor,
        //       //     borderRadius: BorderRadius.circular(10),
        //       //   ),
        //       //   // child: const Center(
        //       //   //   child: Text(
        //       //   //     '15s rest',
        //       //   //     style: TextStyle(
        //       //   //       color: Color(0xFF839fed),
        //       //   //     ),
        //       //   //   ),
        //       //   // ),
        //       // ),
        //       // DottedLineWidget(
        //       //   dottedCount: (screenWidth - 60),
        //       //   context: context,
        //       // )
        //       Divider(color: Theme.of(context).scaffoldBackgroundColor,)
        //     ],
        //   ),
        // )
      ],
    );
  }
}
