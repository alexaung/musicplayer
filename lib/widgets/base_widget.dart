import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/just_audio/components/bottom_panel.dart';
import 'package:thitsarparami/widgets/bottom_player_spacer.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(child: child),
                const BottomPlayerSpacer(),
              ],
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomPanel(),
          ),
        ],
      ),
    );
  }
}
