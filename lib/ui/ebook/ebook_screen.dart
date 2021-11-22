import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/db/blocs/blocs.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/helper/enum.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/ebook/components/pdf_viewer.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';
import 'package:thitsarparami/ui/library/pdf_screen.dart';

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

    return Scaffold(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    itemCount: eBookState.eBooks.length,
                    itemBuilder: (_, int index) {
                      return LineItem(
                        index: index,
                        ebook: eBookState.eBooks[index],
                        monk: widget.monk!,
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
}

class LineItem extends StatefulWidget {
  final int index;
  final Ebook ebook;
  final Monk monk;
  const LineItem(
      {Key? key, required this.index, required this.ebook, required this.monk})
      : super(key: key);

  @override
  _LineItemState createState() => _LineItemState();
}

class _LineItemState extends State<LineItem> {
  //late DownloaderUtils options;
  //late DownloaderCore core;
  late final String path;
  //late double progress;
  //late bool isPause;
  List<Map> downloadsListMaps = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
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
        content: AutoSizeText('$title စာအုပ်ကို ဒေါင်းလုဒ် စတင်ပါပြီ။'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Show all',
            onPressed: () {
              pushNewScreen(context,
                  screen: const PdfScreen(),
                  pageTransitionAnimation: PageTransitionAnimation.scale);
            }),
      ),
    );
  }

  // void _fileDownload(Ebook ebook) async {
  //   String fileName = ebook.url.toString().split("/").last;
  //   options = DownloaderUtils(
  //     progressCallback: (current, total) {
  //       if (!mounted) {
  //         return;
  //       }
  //       setState(() {
  //         progress = (current / total) * 100;
  //       });
  //     },
  //     file: File('$path/pdf/$fileName'),
  //     progress: ProgressImplementation(),
  //     onDone: () {
  //       _showToast(context, ebook.title);
  //       progress = 0.0;
  //     },
  //     deleteOnCancel: true,
  //   );
  //   core = await Flowder.download(ebook.url, options);
  // }

  Future<void> requestDownload(
      BuildContext context, Ebook ebook, Monk monk) async {
    String _name = ebook.url.toString().split("/").last;

    var _localPath = '$path/pdf';
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? _taskid = await FlutterDownloader.enqueue(
        url: ebook.url,
        fileName: _name,
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: false,
      );

      _showToast(context, ebook.title);

      DownloadedEbook dlEbook = DownloadedEbook(
        id: ebook.id,
        taskId: _taskid!,
        title: ebook.title,
        url: ebook.url,
        thumbnail: ebook.thumbnail,
        monkName: monk.title,
        monkImageUrl: monk.imageUrl,
      );
      BlocProvider.of<DownloadedEbookBloc>(context)
          .add(CreateEbook(ebook: dlEbook));

      // ignore: avoid_print
      print(_taskid);
    });
  }

  @override
  Widget build(BuildContext context) {
    Ebook ebook = widget.ebook;

    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            String _name = ebook.url.toString().split("/").last;
            pushNewScreen(context,
                screen: PdfViewer(
                  title: ebook.title,
                  url: ebook.loadPDF == LoadPDF.file
                      ? '$path/pdf/$_name'
                      : ebook.url,
                  loadPDF: ebook.loadPDF,
                ),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.scale);
          },
          child: Container(
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
                          IconButton(
                            icon: const Icon(Icons.download_outlined),
                            onPressed: () async {
                              requestDownload(context, ebook, widget.monk);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
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
