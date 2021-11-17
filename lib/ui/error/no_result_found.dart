import 'package:flutter/material.dart';

class NoResultFoundScreen extends StatelessWidget {
  final String title;
  final String subTitle;
  const NoResultFoundScreen({Key? key, required this.title, this.subTitle = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/outer_space.png"),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
