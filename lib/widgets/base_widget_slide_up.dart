import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thitsarparami/ui/just_audio/now_playing_screen.dart';

class BaseWidget extends StatefulWidget {
  final Widget child;
  const BaseWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  late PanelController _panelController;

  @override
  void initState() {
    _panelController = PanelController();

    super.initState();
  }

  @override
  void dispose() {
    _panelController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double _radius = 25.0;
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: SlidingUpPanel(
        panel: const ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_radius),
            topRight: Radius.circular(_radius),
          ),
          child: NowPlayingScreen(
            //controller: _panelController,
          ),
        ),
        controller: _panelController,
        minHeight: 165,
        maxHeight: MediaQuery.of(context).size.height,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(_radius),
          topRight: Radius.circular(_radius),
        ),
        collapsed: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
            ),
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   stops: const [
            //     0.0,
            //     0.7,
            //   ],
            //   colors: [
            //     //Theme.of(context).primaryColorDark,
            //     Theme.of(context).primaryColor,
            //     Theme.of(context).primaryColorLight,
            //   ],
            // ),
          ),
          child: Container(),
        ),
        body: Column(
          children: [
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}
