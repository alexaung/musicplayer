import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/blocs/monk/monk_bloc.dart';
import 'package:thitsarparami/models/models.dart';

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
    return Scaffold(
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
            final error = monkState.error;
            String message = '$error\n Tap to Retry.';
            return Text(message);
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
                        onTap: () {},
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
    );
  }

  Widget _listView(int index, List<MonkModel> monks) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(monks[index].imageUrl),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                monks[index].title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        // const SizedBox(
        //   height: 15,
        // ),
        Divider(color: Theme.of(context).dividerColor,),
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
