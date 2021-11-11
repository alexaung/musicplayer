import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/chanting/chapter_screen.dart';
import 'package:thitsarparami/ui/chanting/components/chanting_icons.dart';
import 'package:thitsarparami/widgets/base_widget.dart';

class ChantingScreen extends StatefulWidget {
  static const routeName = '/chanting';
  const ChantingScreen({Key? key}) : super(key: key);

  @override
  State<ChantingScreen> createState() => _ChantingScreenState();
}

class _ChantingScreenState extends State<ChantingScreen> {
  _loadChantings() async {
    BlocProvider.of<ChantingBloc>(context).add(const GetChantingsEvent());
  }

  @override
  void initState() {
    super.initState();
    _loadChantings();
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
            'ဘုရားရှိခိုးအမျိူးမျိူးနှင့်ဝတ်ရွတ်စဥ်',
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
        body: BlocBuilder<ChantingBloc, ChantingState>(
          builder: (BuildContext context, ChantingState chantingState) {
            if (ChantingState is ChantingError) {
              return const SomethingWentWrongScreen();
            } else if (chantingState is ChantingLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      itemCount: chantingState.chantings.length,
                      itemBuilder: (_, int index) {
                        return GestureDetector(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: ChapterScreen(
                                chanting: chantingState.chantings[index],
                              ),
                              pageTransitionAnimation: PageTransitionAnimation.scale
                            );
                          },
                          child: _listView(index, chantingState.chantings),
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

  Widget _listView(int index, List<Chanting> chantings) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              ChantingIcon(
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
                          chantings[index].title,
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
              )
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }
}
