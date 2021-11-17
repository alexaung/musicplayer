import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/blocs/bloc.dart';

class BottomPlayerSpacer extends StatefulWidget {
  const BottomPlayerSpacer({Key? key}) : super(key: key);

  @override
  _BottomPlayerSpacerState createState() => _BottomPlayerSpacerState();
}

class _BottomPlayerSpacerState extends State<BottomPlayerSpacer> {
  @override
  Widget build(BuildContext context) {
    //const double _radius = 25.0;
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (BuildContext context, PlayerState playerState) {
        if (playerState is Playing) {
          return Container(
            height: 120,
            color: Colors.black12,
            //width: double.infinity,
            //alignment: Alignment.bottomCenter,
            
            // decoration:  BoxDecoration(
            //   color: Theme.of(context).primaryColor,
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(_radius),
            //     topRight: Radius.circular(_radius),
            //   ),
              
            // ),
          );
        } else {
          return const SizedBox(
            height: 50,
          );
        }
      },
    );
  }
}
