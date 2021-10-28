import 'package:flutter/material.dart';

class AlbumIcon extends StatelessWidget {
  final Color color;

  const AlbumIcon({Key? key, required this.color})  : super(key: key);

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
          Icons.album_outlined,
          color: color,
          size: 32.0,
        ),
      ),
    );
  }
}