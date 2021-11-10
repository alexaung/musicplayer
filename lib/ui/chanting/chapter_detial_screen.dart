import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:thitsarparami/models/models.dart';

class ChapterDetailScreen extends StatefulWidget {
  static const routeName = '/chapter_detail';
  final Chanting? chanting;
  final int pageIndex;
  const ChapterDetailScreen({Key? key, this.pageIndex = 1, this.chanting})
      : super(key: key);

  @override
  State<ChapterDetailScreen> createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  late PageController pageController;
  int currentPageIndex = 0;
  @override
  void initState() {
    currentPageIndex = widget.pageIndex;
    pageController = PageController(initialPage: widget.pageIndex);
    super.initState();
  }

  @override
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: AutoSizeText(
          widget.chanting!.title,
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Container(
            //color: Colors.amberAccent,
            padding: const EdgeInsets.only(bottom: 10),
            child: AutoSizeText(
              "${NumberFormat("###", "my_MM").format(currentPageIndex + 1)}။ ${widget.chanting!.chapters![currentPageIndex].title}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.chanting!.chapters!.length,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        itemBuilder: (context, index) {
          Chapter chapter = widget.chanting!.chapters![index];
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Html(
                data: chapter.text,
                style: {
                  "body": Style(
                    fontSize: const FontSize(18.0),
                    //fontWeight: FontWeight.w600,
                    lineHeight: LineHeight.em(1.5)
                  ),
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
