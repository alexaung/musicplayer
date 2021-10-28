import 'package:flutter/material.dart';

class PlayIcon extends StatelessWidget {
  final Color color;

  const PlayIcon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _radius = 55;
    return Container(
      width: _radius,
      height: _radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(
          _radius,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.play_arrow,
          color: color,
          size: 32.0,
        ),
      ),
    );
  }
}

class PauseIcon extends StatelessWidget {
  final Color color;

  const PauseIcon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _radius = 55;
    return Container(
      width: _radius,
      height: _radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(
          _radius,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.pause,
          color: color,
          size: 32.0,
        ),
      ),
    );
  }
}

class ShowIcon extends StatelessWidget {
  final Color color;

  const ShowIcon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _radius = 32;
    return Container(
      width: _radius,
      height: _radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(
          _radius,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.keyboard_arrow_up,
          color: color,
          size: 22.0,
        ),
      ),
    );
  }
}

class HideIcon extends StatelessWidget {
  final Color color;

  const HideIcon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _radius = 32;
    return Container(
      width: _radius,
      height: _radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(
          _radius,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.keyboard_arrow_down,
          color: color,
          size: 22.0,
        ),
      ),
    );
  }
}

class CircularProgressIndicatorIcon extends StatelessWidget {
  final Color color;

  const CircularProgressIndicatorIcon({Key? key, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _radius = 55;
    return Container(
      width: _radius,
      height: _radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(
          _radius,
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
