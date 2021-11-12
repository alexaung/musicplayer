import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/ebook/components/pdf_viewer.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';
import 'package:thitsarparami/widgets/base_widget.dart';

class EbookScreen extends StatefulWidget {
  static const routeName = '/ebook';
  final Monk? monk;
  const EbookScreen({Key? key, this.monk}) : super(key: key);

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
  // List Ebooks = [];
  _loadEbooks() async {
    BlocProvider.of<EbookBloc>(context).add(const GetEbooksEvent());
  }

  @override
  void initState() {
    super.initState();
    _loadEbooks();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Monk;

    return BaseWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        body: BlocBuilder<EbookBloc, EbookState>(
          builder: (BuildContext context, EbookState eBookState) {
            if (EbookState is EbookError) {
              // final error = EbookState.error;
              // String message = '$error\n Tap to Retry.';
              return const SomethingWentWrongScreen();
            } else if (eBookState is EbookLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      itemCount: eBookState.eBooks.length,
                      itemBuilder: (_, int index) {
                        return GestureDetector(
                            onTap: () {
                              pushNewScreen(context,
                                  screen: PdfViewer(
                                    eBook: eBookState.eBooks[index],
                                  ),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.scale);
                            },
                            child: LineItem(
                              index: index,
                              ebook: eBookState.eBooks[index],
                            ));
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
}

class LineItem extends StatefulWidget {
  final int index;
  final Ebook ebook;
  const LineItem({Key? key, required this.index, required this.ebook})
      : super(key: key);

  @override
  _LineItemState createState() => _LineItemState();
}

class _LineItemState extends State<LineItem> {
  late DownloaderUtils options;
  late DownloaderCore core;
  late final String path;
  late double progress;
  late bool isPause;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    progress = 0.0;
    isPause = false;
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    path = (await getApplicationDocumentsDirectory()).path;
  }

  void _showToast(BuildContext context, String title) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: AutoSizeText('$title စာအုပ်ကို ဒေါင်းလုဒ် ပြီးပါပြီ။'),
        duration: const Duration(seconds: 3),
        // action: SnackBarAction(
        //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _fileDownload(Ebook ebook) async {
    String fileName = ebook.url.toString().split("/").last;
    options = DownloaderUtils(
      progressCallback: (current, total) {
        if (!mounted) {
          return;
        }
        setState(() {
          progress = (current / total) * 100;
        });
      },
      file: File('$path/pdf/$fileName'),
      progress: ProgressImplementation(),
      onDone: () {
        _showToast(context, ebook.title);
        progress = 0.0;
      },
      deleteOnCancel: true,
    );
    core = await Flowder.download(ebook.url, options);
  }

  @override
  Widget build(BuildContext context) {
    Ebook ebook = widget.ebook;

    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(30.0, 5.0, 10.0, 5.0),
          constraints: const BoxConstraints(
            minHeight: 170.0,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(100.0, 20.0, 10.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      //width: MediaQuery.of(context).size.width - 180,
                      child: AutoSizeText(
                        ebook.title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: 55.0,
                          lineWidth: 3.0,
                          percent: progress / 100,
                          center: progress == 0.0
                              ? IconButton(
                                  icon: const Icon(Icons.download_outlined),
                                  onPressed: () async {
                                    _fileDownload(ebook);
                                  },
                                )
                              : (isPause
                                  ? IconButton(
                                      icon: const Icon(Icons.download_outlined),
                                      onPressed: () async {
                                        setState(() {
                                          isPause = false;
                                        });
                                        core.resume();
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.pause),
                                      onPressed: () async {
                                        setState(() {
                                          isPause = true;
                                        });
                                        core.pause();
                                      },
                                    )),
                          backgroundColor: progress > 0.0
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).backgroundColor,
                          progressColor: Theme.of(context).primaryColor,
                        ),
                        progress > 0
                            ? IconButton(
                                icon: const Icon(Icons.cancel_outlined),
                                color: Colors.red,
                                onPressed: () async {
                                  setState(() {
                                    progress = 0.0;
                                  });
                                  core.cancel();
                                },
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                      ],
                    )
                  ],
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // progress > 0
                //     ? Row(
                //         children: [
                //           Expanded(
                //             child: LinearPercentIndicator(
                //               lineHeight: 8.0,
                //               percent: progress / 100,
                //               backgroundColor:
                //                   Theme.of(context).scaffoldBackgroundColor,
                //               progressColor: Theme.of(context).primaryColor,
                //             ),
                //           ),
                //         ],
                //       )
                //     : const SizedBox(
                //         height: 0,
                //       ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 10.0,
          top: 15.0,
          bottom: 15.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              width: 110.0,
              //height: 250,
              fit: BoxFit.cover,
              imageUrl: ebook.thumbnail,
              placeholder: (context, url) => Container(color: Colors.black12),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                size: 100,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
