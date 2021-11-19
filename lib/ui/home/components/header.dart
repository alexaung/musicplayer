import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/home/components/menu.dart';
import 'package:thitsarparami/ui/home/components/myanmar_calender.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screeWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 0, right: 0, bottom: 10),
      width: screeWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Container(
                width: screeWidth * 0.6,
                padding: const EdgeInsets.only(top: 20, left: 10, right: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'သစ္စာပါရမီဓမ္မရိပ်သာမှ',
                      style: Theme.of(context).textTheme.headline1,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      'ဓမ္မအလှူ ခံသူများ',
                      style: Theme.of(context).textTheme.headline2,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      'နှလုံးသား တရားကိန်းဝပ်နိုင်ပါစေ။',
                      style: Theme.of(context).textTheme.headline3,
                      maxLines: 1,
                    ),

                    // Row(
                    //   children: [
                    //     AutoSizeText(
                    //       'တရားနာရန်',
                    //       style: Theme.of(context).textTheme.headline3,
                    //       maxLines: 1,
                    //     ),
                    //     const SizedBox(
                    //       width: 5,
                    //     ),
                    //     Icon(
                    //       Icons.play_circle_outline,
                    //       size: 20,
                    //       color: Theme.of(context).appBarTheme.iconTheme!.color,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              Container(
                width: 150, //screeWidth * 0.5,
                height: 150, //screeHeight * 0.19,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/buddha.png"),
                      fit: BoxFit.contain),
                ),
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: const MyanmarCalender(),
          ),
          const MenuContainer(),
        ],
      ),
    );
  }
}
