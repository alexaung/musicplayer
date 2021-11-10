import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/chanting/chapter_detial_screen.dart';
import 'package:thitsarparami/widgets/base_widget.dart';

class ChapterScreen extends StatelessWidget {
  static const routeName = '/chapter';
  final Chanting? chanting;
  const ChapterScreen({Key? key, this.chanting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: AutoSizeText(
            chanting!.title,
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: chanting!.chapters!.length,
                itemBuilder: (_, int index) {
                  return GestureDetector(
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: ChapterDetailScreen(
                          chanting: chanting,
                          pageIndex: index,
                        ),
                      );
                    },
                    child: _listView(context, index, chanting!),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _listView(BuildContext context, int index, Chanting chanting) {
  _onTap() {
    pushNewScreen(
      context,
      screen: ChapterDetailScreen(
        chanting: chanting,
        pageIndex: index,
      ),
    );
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ChapterCard(
          title: chanting.chapters![index].title,
          chapterNumber: index + 1,
          press: () {
            _onTap();
          },
        ),
      ),
    ],
  );
}

class ChapterCard extends StatelessWidget {
  final String title;
  final int chapterNumber;
  final Function press;
  const ChapterCard({
    Key? key,
    required this.title,
    required this.chapterNumber,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    String no = NumberFormat("###", "my_MM").format(chapterNumber);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38.5),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 33,
            color: const Color(0xFFD3D3D3).withOpacity(.84),
          ),
        ],
      ),
      child: Row(
        children: [
          AutoSizeText(
            "$no။ $title",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onPressed: () {
              press();
            },
          )
        ],
      ),
    );
  }
}
