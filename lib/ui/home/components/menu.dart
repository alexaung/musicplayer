import 'package:flutter/material.dart';
import 'monk_carousel.dart';

class MenuContainer extends StatelessWidget {
  const MenuContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(70),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 85,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    height: 85,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          offset: const Offset(8, 10),
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 85,
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
                    height: 85,
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
              height: 85,
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
                    height: 85,
                    //color: AppColor.gradientFirst,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          offset: const Offset(8, 10),
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 85,
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
                    height: 85,
                    margin: const EdgeInsets.only(top: 8, left: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'ဓမ္မပို့ချချက်',
                          style: TextStyle(
                            fontSize: 16,
                            // color: color.AppColor.homePageTitleColor,
                          ),
                        ),
                        Text(
                          'MP3 တရားတော်များ',
                          style: TextStyle(
                            fontSize: 16,
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
              height: 85,
              width: MediaQuery.of(context).size.width,
              // color: AppColor.gradientFifth,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    height: 85,
                    //color: AppColor.gradientFirst,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          offset: const Offset(8, 10),
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 85,
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
                    height: 85,
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
                  padding: const EdgeInsets.all(5),
                  height: 75,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        offset: const Offset(8, 10),
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.video_camera_front_outlined,
                        size: 40,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Live Streaming',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 50) / 2,
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 20),
                  padding: const EdgeInsets.all(5),
                  height: 75,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        offset: const Offset(8, 10),
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.radio_outlined,
                        size: 40,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Online Radio',
                        style: TextStyle(
                          fontSize: 15,
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
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.18),
                  ),
                ],
              ),
              child: const MonkCarousel(),
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
