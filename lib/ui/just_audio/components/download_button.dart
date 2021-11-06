import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:thitsarparami/helper/enum.dart';
import 'package:thitsarparami/ui/just_audio/components/favourite_form.dart';
import 'package:thitsarparami/ui/just_audio/components/favourite_list.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({Key? key}) : super(key: key);

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  late DownloaderUtils options;
  late DownloaderCore core;
  late final String path;
  late double progress;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    progress = 0;
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    path = (await getApplicationDocumentsDirectory()).path;
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const AutoSizeText('Download Completed'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _showModalBottomSheet(MediaItem song) {
    const double _radius = 25.0;
    String fileName = song.extras!['url'].toString().split("/").last;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_radius),
          topRight: Radius.circular(_radius),
        ),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                const FavouriteForm(
                  socialMode: SocialMode.download,
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                ),
                Expanded(
                  child: FavouriteListView(
                    socialMode: SocialMode.download,
                    controller: scrollController,
                  ),
                )
              ],
            );
          },
        );
      },
    ).whenComplete(
      () async => {
        options = DownloaderUtils(
          progressCallback: (current, total) {
            setState(() {
              progress = (current / total) * 100;
            });
            // print('Downloading: $progress');
          },
          file: File('$path/mp3/$fileName'),
          progress: ProgressImplementation(),
          onDone: () {
            _showToast(context);
            progress = 0;
          },
          deleteOnCancel: true,
        ),
        core = await Flowder.download(song.extras!['url'], options),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final playerManager = getIt<PlayerManager>();
    return ValueListenableBuilder<MediaItem>(
      valueListenable: playerManager.currentSongNotifier,
      builder: (_, song, __) {
        return CircularPercentIndicator(
          radius: 55.0,
          lineWidth: 3.0,
          percent: progress / 100,
          center: IconButton(
            icon: const Icon(Icons.download_outlined),
            onPressed: () async {
              _showModalBottomSheet(song);
            },
          ),
          backgroundColor: progress > 0
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).backgroundColor,
          progressColor: Theme.of(context).primaryColor,
        );
      },
    );
  }
}
