import 'package:flutter/material.dart';

class ChantingIcon extends StatelessWidget {
  final Color color;

  const ChantingIcon({Key? key, required this.color}) : super(key: key);

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
        child: ImageIcon(
          const AssetImage('assets/images/prayer.png'),
          size: 32,
          color: color,
        ),
      ),
    );
  }
}
