import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:thitsarparami/models/album.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/play_button_notifier.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/progress_notifier.dart';
import 'package:thitsarparami/ui/just_audio/notifiers/repeat_button_notifier.dart';
import 'package:thitsarparami/ui/just_audio/services/player_mode.dart';
import 'package:thitsarparami/ui/just_audio/services/playlist_repository.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';

class PlayerManager {
  // Listeners: Updates going to the UI
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  final _audioHandler = getIt<AudioHandler>();

  // Events: Calls coming from the UI
  void init(PlayerMode mode) async {
    //await _loadPlaylist();
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
  }

  // Future<void> _loadPlaylist() async {
  //   final songRepository = getIt<SongRespository>();
  //   final playlist = await songRepository.fetchSongs();
  //   final mediaItems = playlist
  //       .map((song) => MediaItem(
  //             id: song.id.toString(),
  //             // album: widget.album!.title, //song['album'] ?? '',
  //             title: song.title,
  //             // artist: widget.monk!.title,
  //             // artUri: Uri.parse(widget.monk!.imageUrl),
  //             extras: {'url': song.url},
  //           ))
  //       .toList();
  //   _audioHandler.addQueueItems(mediaItems);
  // }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        playlistNotifier.value = [];
        currentSongTitleNotifier.value = '';
      } else {
        final newList = playlist.map((item) => item.title).toList();
        playlistNotifier.value = newList;
      }
      _updateSkipButtons();
    });
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongTitleNotifier.value = mediaItem?.title ?? '';
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  Future<void> loadPlaylist(Monk monk, Album album) async {
    final songRepository = getIt<SongRespository>();
    final playlist = await songRepository.fetchSongs();
    final mediaItems = playlist
        .map((song) => MediaItem(
              id: song.id.toString(),
              album: album.title, 
              title: song.title,
              artist: monk.title,
              artUri: Uri.parse(monk.imageUrl),
              extras: {'url': song.url},
            ))
        .toList();
    _audioHandler.addQueueItems(mediaItems);
  }

  Future<void> updateQueue(List<MediaItem> queue) async {
    _audioHandler.addQueueItems(queue);
  }

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();

  void skipToQueueItem(int index) => _audioHandler.skipToQueueItem(index);

  void seek(Duration position) => _audioHandler.seek(position);

  void previous() => _audioHandler.skipToPrevious();
  void next() => _audioHandler.skipToNext();

  void repeat() {
    repeatButtonNotifier.nextState();
    final repeatMode = repeatButtonNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  Future<void> addRadioUrl(String url) async {
    const mediaItem = MediaItem(
      id: 'radio',
      album: 'Radio',
      title: '24 Hours Radio',
      extras: {'url': 'https://edge.mixlr.com/channel/nmtev'},
    );

    _audioHandler.addQueueItem(mediaItem);
  }

  void emptyPlaylist() {
    while (_audioHandler.queue.value.isNotEmpty) {
      final lastIndex = _audioHandler.queue.value.length - 1;
      if (lastIndex < 0) return;
      _audioHandler.removeQueueItemAt(lastIndex);
    }
  }

  void deleteRadioUrl() {
    final index =
        _audioHandler.queue.value.indexWhere((item) => item.id == 'radio');
    if (index >= 0) {
      _audioHandler.removeQueueItemAt(index);
    }
  }

  Future<void> add() async {
    final songRepository = getIt<PlaylistRepository>();
    final song = await songRepository.fetchAnotherSong();
    final mediaItem = MediaItem(
      id: song['id'] ?? '',
      album: song['album'] ?? '',
      title: song['title'] ?? '',
      extras: {'url': song['url']},
    );
    _audioHandler.addQueueItem(mediaItem);
  }

  void remove() {
    final lastIndex = _audioHandler.queue.value.length - 1;
    if (lastIndex < 0) return;
    _audioHandler.removeQueueItemAt(lastIndex);
  }

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }
}
