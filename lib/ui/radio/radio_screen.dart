import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/just_audio/components/audio_control_button/play_button.dart';
import 'package:thitsarparami/ui/just_audio/components/audio_progress_bar.dart';
import 'package:thitsarparami/ui/just_audio/components/current_song_image.dart';
import 'package:thitsarparami/ui/just_audio/components/current_song_title.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/player_mode.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';

class RadioScreen extends StatefulWidget {
  static const routeName = '/radio';
  const RadioScreen({Key? key}) : super(key: key);

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final _itemsView = GlobalKey();
  double _stackHeight = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      RenderBox stackRB =
          _itemsView.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _stackHeight = stackRB.size.height;
      });
    });

    getIt<PlayerManager>().init(PlayerMode.radio);
    //_loadUrl();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColorDark,
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorLight,
                  ],
                  stops: const [
                    0.0,
                    0.5,
                    0.7,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            // height: screenHeight / 3,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  // advancedPlayer.stop();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.11 + 75,
            key: _itemsView,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(40)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const RadioTitle(),
                    const SizedBox(
                      height: 10,
                    ),
                    const AudioProgressBar(),
                    AudioControlButtons(
                      animationController: animationController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.11,
            left: (screenWidth - 150) / 2,
            right: (screenWidth - 150) / 2,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Theme.of(context).primaryColorLight, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CurrentSongImage(
                  animationController: animationController,
                ),
              ),
            ),
          ),
          Container(
            height: _stackHeight + (screenHeight * 0.11 + 75 + 25),
          )
        ],
      ),
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  final AnimationController animationController;
  const AudioControlButtons({Key? key, required this.animationController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PlayButton(animationController: animationController),
        ],
      ),
    );
  }
}


