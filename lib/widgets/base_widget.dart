import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: child),
          Container(
            height: 0,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
