import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  const AudioFile({Key? key, required this.advancedPlayer, required this.audioPath}) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;

  Color color = Colors.black;
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();
    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d.inMilliseconds < 0 ? const Duration(hours: 24) : d;
      });
    });
    widget.advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    widget.advancedPlayer.setUrl(widget.audioPath);
    widget.advancedPlayer.onPlayerCompletion.listen((event) {
      _position = const Duration(seconds: 0);
      setState(() {
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      onPressed: () {
        if (isPlaying == false) {
          widget.advancedPlayer.play(widget.audioPath);
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          widget.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
      icon: isPlaying == false
          ? Icon(
              _icons[0],
              size: 50,
              color: Theme.of(context).primaryIconTheme.color,
            )
          : Icon(
              _icons[1],
              size: 50,
              color: Theme.of(context).primaryIconTheme.color,
            ),
    );
  }

  bthFast() {
    return IconButton(
      onPressed: () {
        widget.advancedPlayer.setPlaybackRate(1.5);
      },
      icon: Icon(
        Icons.fast_forward,
        size: 25,
        color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
    );
  }

  bthSlow() {
    return IconButton(
      onPressed: () {
        widget.advancedPlayer.setPlaybackRate(0.5);
      },
      icon: Icon(
        Icons.fast_rewind,
        size: 25,
        color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
    );
  }

  Widget btnLoop() {
    return IconButton(
      onPressed: () {
        widget.advancedPlayer.setPlaybackRate(0.5);
      },
      icon: Icon(
        Icons.shuffle,
        size: 25,
        color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
    );
  }

  Widget btnRepeat() {
    return IconButton(
      onPressed: () {
        if (isRepeat == false) {
          widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat == true;
          });
        } else if (isRepeat == true) {
          widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
          setState(() {
            isRepeat == false;
          });
        }
      },
      icon: Icon(
        Icons.repeat,
        size: 25,
        color: isRepeat
            ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor!
            : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Theme.of(context).primaryColor,
      inactiveColor: Theme.of(context).scaffoldBackgroundColor,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  Widget loadAsset() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // btnRepeat(),
        // bthSlow(),
        btnStart(),
        // bthFast(),
        // btnLoop(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              _position.toString().split(".")[0],
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              _duration.toString().split(".")[0],
              style: const TextStyle(fontSize: 16),
            ),
          ]),
        ),
        slider(),
        loadAsset()
      ],
    );
  }
}
