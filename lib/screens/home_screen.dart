// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:thitsarparami/screens/colors.dart';
import 'package:thitsarparami/widgets/bottom_navigation_bar.dart';
import 'colors.dart' as color;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.gradientFirst,
            AppColor.gradientSecond,
            AppColor.gradientThird,
            AppColor.gradientFourth,
            AppColor.gradientFifth,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: const [
                  HeaderContainer(),
                  MenuContainer(),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomNavigationBarWidget(),
      ),
    );
  }
}



class MenuContainer extends StatelessWidget {
  const MenuContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.homePageMenuBackground,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(70),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              // color: AppColor.gradientFifth,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    height: 100,
                    //color: AppColor.gradientFirst,
                    decoration: BoxDecoration(
                      color: AppColor.homePageMenuBackground,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          offset: const Offset(8, 10),
                          color: AppColor.gradientSecond.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 220,
                    ),
                    decoration: BoxDecoration(
                      // color: AppColor.gradientFirst,
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/mp3_meditating.png"),
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 100,
                    margin: const EdgeInsets.only(top: 10, left: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'MP3 တရားတော်များ',
                          style: TextStyle(
                            fontSize: 18,
                            // color: color.AppColor.homePageTitleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              // color: AppColor.gradientFifth,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                    ),
                    height: 100,
                    //color: AppColor.gradientFirst,
                    decoration: BoxDecoration(
                      color: AppColor.homePageMenuBackground,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          offset: const Offset(8, 10),
                          color: AppColor.gradientSecond.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 220,
                    ),
                    decoration: BoxDecoration(
                      // color: AppColor.gradientFirst,
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/meditation.png"),
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 100,
                    margin: const EdgeInsets.only(top: 10, left: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'ဓမ္မပို့ချချက်',
                          style: TextStyle(
                            fontSize: 18,
                            // color: color.AppColor.homePageTitleColor,
                          ),
                        ),
                        Text(
                          'MP3 တရားတော်များ',
                          style: TextStyle(
                            fontSize: 18,
                            // color: color.AppColor.homePageTitleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              // color: AppColor.gradientFifth,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    height: 100,
                    //color: AppColor.gradientFirst,
                    decoration: BoxDecoration(
                      color: AppColor.homePageMenuBackground,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          offset: const Offset(8, 10),
                          color: AppColor.gradientSecond.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 220,
                    ),
                    decoration: BoxDecoration(
                      // color: AppColor.gradientFirst,
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/reading.png"),
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 100,
                    margin: const EdgeInsets.only(top: 10, left: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'ဓမ္မစာအုပ်များ',
                          style: TextStyle(
                            fontSize: 18,
                            // color: color.AppColor.homePageTitleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width - 50) / 2,
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 5),
                  padding: const EdgeInsets.all(10),
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColor.homePageMenuBackground,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        offset: const Offset(8, 10),
                        color: AppColor.gradientSecond.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.video_camera_front_outlined,
                        size: 50,
                        color: AppColor.gradientSecond,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Live Streaming',
                        style: TextStyle(
                          fontSize: 15,
                          //color: color.AppColor.homePageTitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 50) / 2,
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 20),
                  padding: const EdgeInsets.all(10),
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColor.homePageMenuBackground,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        offset: const Offset(8, 10),
                        color: AppColor.gradientSecond.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.radio_outlined,
                        size: 50,
                        color: AppColor.gradientSecond,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Online Radio',
                        style: TextStyle(
                          fontSize: 15,
                          //color: color.AppColor.homePageTitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'တရားတော်အသစ်များ',
              style: TextStyle(
                fontSize: 18,
                // color: color.AppColor.homePageTitleColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    offset: const Offset(8, 10),
                    color: AppColor.gradientSecond.withOpacity(0.3),
                  ),
                ],
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: (MediaQuery.of(context).size.width - 50) / 2,
                  // aspectRatio: 16/6,
                  // enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(
                    milliseconds: 800,
                  ),
                  viewportFraction: 0.5,
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 0),
                        decoration: BoxDecoration(
                          color: AppColor.homePageMenuBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/3.png"),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'မင်းကွန်းဆရာတော်ဘုရားကြီ:',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Row(
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
                  style: TextStyle(
                    fontSize: 18,
                    color: color.AppColor.homePageTitleColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'ဝတ်ရွတ်စဥ်',
                  style: TextStyle(
                    fontSize: 25,
                    color: color.AppColor.homePageTitleColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'တရားနာရန်',
                      style: TextStyle(
                        fontSize: 14,
                        color: color.AppColor.homePageTitleColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.play_circle_outline,
                      size: 20,
                      color: AppColor.homePageTitleColor,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 150,
            //height: 150,
            decoration: const BoxDecoration(
              //color: Colors.amber,
              image: DecorationImage(
                  image: AssetImage("assets/images/buddha.png"),
                  fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}
