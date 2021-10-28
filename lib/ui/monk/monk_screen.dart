import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/error/something_went_wrong.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/album/album_screen.dart';
import 'package:thitsarparami/widgets/base_widget.dart';

class MonkScreen extends StatefulWidget {
  static const routeName = '/monk';
  final String? title;
  const MonkScreen({Key? key, this.title}) : super(key: key);

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
          title: Text(
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
        ),
        body: BlocBuilder<MonkBloc, MonkState>(
          builder: (BuildContext context, MonkState monkState) {
            if (monkState is MonkError) {
              //final error = monkState.error;
              //String message = '$error\n Tap to Retry.';
              return const SomethingWentWrongScreen();
            } else if (monkState is MonkLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      itemCount: monkState.monks.length,
                      itemBuilder: (_, int index) {
                        return GestureDetector(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: AlbumScreen(
                                monk: monkState.monks[index],
                              ),
                            );
                          },
                          child: _listView(index, monkState.monks),
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

  Widget _listView(int index, List<Monk> monks) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              flex: 4,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(monks[index].imageUrl),
                      fit: BoxFit.cover),
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
                        Text(
                          monks[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
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
