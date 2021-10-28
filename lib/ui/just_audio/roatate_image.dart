import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotateImage extends StatefulWidget {
  final String imageUrl;
  final AnimationController animationController;
  const RotateImage(
      {Key? key, required this.animationController, required this.imageUrl})
      : super(key: key);

  @override
  RotateImageState createState() => RotateImageState();
}

class RotateImageState extends State<RotateImage>
    with SingleTickerProviderStateMixin {
  // late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    // widget.animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 5),
    // );

    widget.animationController.repeat();
  }

  @override
  void dispose() {
    widget.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      child: widget.imageUrl.isEmpty
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColorDark,
                  width: 2,
                ),
                image: const DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.contain,
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColorDark,
                  width: 2,
                ),
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
      builder: (context, child) {
        return Transform.rotate(
          angle: widget.animationController.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
  }
}
