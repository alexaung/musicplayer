import 'package:flutter/material.dart';

class DottedLineWidget extends StatelessWidget {
  const DottedLineWidget({
    Key? key,
    required this.dottedCount,
    required this.context,
  }) : super(key: key);

  final double dottedCount;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < (dottedCount - 1) / 6; i++)
          i.isEven
              ? Container(
                  width: 6,
                  height: 1,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(2)),
                )
              : Container(
                  width: 6,
                  height: 1,
                  color: Theme.of(context).backgroundColor,
                ),
      ],
    );
  }
}