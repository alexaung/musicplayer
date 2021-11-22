import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/db/blocs/blocs.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/ui/error/no_result_found.dart';
import 'package:thitsarparami/ui/error/something_went_wrong.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({Key? key}) : super(key: key);

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final ReceivePort _port = ReceivePort();
  List<Map> downloadsListMaps = [];

  _loadEbooks() async {
    BlocProvider.of<DownloadedEbookBloc>(context)
        .add(const GetDownloadedEbooksEvent());
  }

  @override
  void initState() {
    super.initState();
    _loadEbooks();
    task();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      var task = downloadsListMaps.where((element) => element['id'] == id);
      for (var element in task) {
        element['progress'] = progress;
        element['status'] = status;
        setState(() {});
      }
    });
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Future task() async {
    List<DownloadTask>? getTasks = await FlutterDownloader.loadTasks();
    for (var _task in getTasks!) {
      Map _map = {};
      _map['taskId'] = _task.taskId;
      _map['url'] = _task.url;
      _map['status'] = _task.status;
      _map['progress'] = _task.progress;
      _map['id'] = _task.taskId;
      _map['filename'] = _task.filename;
      _map['savedDirectory'] = _task.savedDir;
      downloadsListMaps.add(_map);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: AutoSizeText(
          "သိမ်းထားသေား တရားစာအုပ်များ",
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
      body: BlocBuilder<DownloadedEbookBloc, DownloadedEbookState>(
        builder: (context, state) {
          if (state is SongError) {
            return const SomethingWentWrongScreen();
          } else if (state is EbooksLoaded) {
            if (state.ebooks.isEmpty || downloadsListMaps.isEmpty) {
              return const NoResultFoundScreen(
                title: 'သိမ်းထားသေားတရားစာအုပ်များ မရှိသေးပါ။',
                subTitle: ' ',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              itemCount: state.ebooks.length,
              itemBuilder: (_, int index) {
                if (downloadsListMaps
                    .where((element) =>
                        element['taskId'] == state.ebooks[index].taskId)
                    .isEmpty) {
                  return Container();
                }
                Map _map = downloadsListMaps
                    .where((element) =>
                        element['taskId'] == state.ebooks[index].taskId)
                    .first;

                //String _filename = _map['filename'];
                int _progress = _map['progress'];
                DownloadTaskStatus _status = _map['status'];
                String _id = _map['id'];
                String _savedDirectory = _map['savedDirectory'];
                List<FileSystemEntity> _directories =
                    Directory(_savedDirectory).listSync(followLinks: true);
                // ignore: unused_local_variable
                FileSystemEntity? _file =
                    _directories.isNotEmpty ? _directories.first : null;

                //String _title = _map['headers']['title'].toString();
                // String _thumbnail =
                //     _map['headers']['thumbnail'].toString();
                return GestureDetector(
                  onTap: () {
                    // pushNewScreen(context,
                    //     screen: PdfViewer(
                    //       eBook: eBookState.eBooks[index],
                    //     ),
                    //     withNavBar: false,
                    //     pageTransitionAnimation:
                    //         PageTransitionAnimation.scale);
                  },
                  child: lineItem(context, state.ebooks[index].title, _status, _id, index,
                      state, _progress),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Stack lineItem(
      BuildContext context,
      String _filename,
      DownloadTaskStatus _status,
      String _id,
      int index,
      EbooksLoaded state,
      int _progress) {
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
                        _filename,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    buttons(_status, _id, index, state.ebooks[index])
                  ],
                ),
                _status == DownloadTaskStatus.complete
                    ? Container()
                    : const SizedBox(height: 5),
                _status == DownloadTaskStatus.complete
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('$_progress%'),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: _progress / 100,
                                    backgroundColor:
                                        Theme.of(context).primaryColorLight,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 10)
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
              imageUrl: state.ebooks[index].thumbnail,
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

  Widget buttons(DownloadTaskStatus _status, String taskid, int index,
      DownloadedEbook ebook) {
    void changeTaskID(String taskid, String newTaskID) {
      Map? task = downloadsListMaps.firstWhere(
        (element) => element['taskId'] == taskid,
        orElse: () => {},
      );
      task['taskId'] = newTaskID;
      setState(() {});
    }

    return _status == DownloadTaskStatus.canceled
        ? GestureDetector(
            child: const Icon(Icons.cached, size: 20, color: Colors.green),
            onTap: () {
              FlutterDownloader.retry(taskId: taskid).then((newTaskID) {
                changeTaskID(taskid, newTaskID!);
              });
            },
          )
        : _status == DownloadTaskStatus.failed
            ? GestureDetector(
                child: const Icon(Icons.cached, size: 20, color: Colors.green),
                onTap: () {
                  FlutterDownloader.retry(taskId: taskid).then((newTaskID) {
                    changeTaskID(taskid, newTaskID!);
                  });
                },
              )
            : _status == DownloadTaskStatus.paused
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: const Icon(Icons.play_arrow,
                            size: 20, color: Colors.blue),
                        onTap: () {
                          FlutterDownloader.resume(taskId: taskid).then(
                            (newTaskID) => changeTaskID(taskid, newTaskID!),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: const Icon(Icons.close,
                            size: 20, color: Colors.red),
                        onTap: () {
                          FlutterDownloader.cancel(taskId: taskid);
                        },
                      )
                    ],
                  )
                : _status == DownloadTaskStatus.running
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            child: const Icon(Icons.pause,
                                size: 20, color: Colors.green),
                            onTap: () {
                              FlutterDownloader.pause(taskId: taskid);
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            child: const Icon(Icons.close,
                                size: 20, color: Colors.red),
                            onTap: () {
                              FlutterDownloader.cancel(taskId: taskid);
                            },
                          )
                        ],
                      )
                    : _status == DownloadTaskStatus.complete
                        ? GestureDetector(
                            child: const Icon(Icons.delete,
                                size: 20, color: Colors.red),
                            onTap: () {
                              downloadsListMaps.removeAt(index);
                              BlocProvider.of<DownloadedEbookBloc>(context).add(
                                DeleteEbook(ebook: ebook),
                              );
                              FlutterDownloader.remove(
                                  taskId: taskid, shouldDeleteContent: true);

                              //setState(() {});
                            },
                          )
                        : Container();
  }
}
