import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/home/components/myanmar_calender.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
      width: MediaQuery.of(context).size.width,
      height: 270,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.amber,
                padding: const EdgeInsets.only(top: 20, left: 30, right: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ဘုရားရှိခိုးအမျိူးမျိူးနှင့်',
                      // style: TextStyle(
                      //   fontSize: 18,
                      //   color: color.AppColor.homePageTitleColor,
                      // ),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'ဝတ်ရွတ်စဥ်',
                      // style: TextStyle(
                      //   fontSize: 25,
                      //   color: color.AppColor.homePageTitleColor,
                      // ),
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'တရားနာရန်',
                          // style: TextStyle(
                          //   fontSize: 14,
                          //   color: color.AppColor.homePageTitleColor,
                          // ),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.play_circle_outline,
                          size: 20,
                          color: Theme.of(context).appBarTheme.iconTheme!.color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  //color: Colors.amber,
                  image: DecorationImage(
                      image: AssetImage("assets/images/buddha.png"),
                      fit: BoxFit.cover),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
            child: const MyanmarCalender(),
          )
        ],
      ),
    );
  }
}
