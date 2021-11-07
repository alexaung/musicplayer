import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/helper/enum.dart';
import 'package:thitsarparami/ui/chanting/chanting_screen.dart';
import 'package:thitsarparami/ui/home/components/monk_carousel.dart';
import 'package:thitsarparami/ui/monk/monk_screen.dart';
import 'package:thitsarparami/ui/radio/radio_screen.dart';
import 'package:thitsarparami/ui/youtube/youtube_screen.dart';

class MenuContainer extends StatelessWidget {
  const MenuContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final autoSizeGroup = AutoSizeGroup();
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(70),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // GestureDetector(
          //   onTap: () => pushNewScreen(
          //     context,
          //     screen: const MonkScreen(
          //       title: 'MP3 တရားတော်များ',
          //       screenMode: MonkScreenMode.album,
          //     ),
          //   ),
          //   child: SizedBox(
          //     height: 85,
          //     width: MediaQuery.of(context).size.width,
          //     child: Stack(
          //       children: [
          //         Container(
          //           alignment: Alignment.topLeft,
          //           width: MediaQuery.of(context).size.width,
          //           margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
          //           height: 85,
          //           decoration: BoxDecoration(
          //             color: Theme.of(context).scaffoldBackgroundColor,
          //             borderRadius: BorderRadius.circular(20),
          //             boxShadow: [
          //               BoxShadow(
          //                 blurRadius: 40,
          //                 offset: const Offset(8, 10),
          //                 color:
          //                     Theme.of(context).primaryColor.withOpacity(0.3),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           width: MediaQuery.of(context).size.width,
          //           height: 85,
          //           margin: const EdgeInsets.only(
          //             top: 10,
          //             left: 20,
          //             right: 220,
          //           ),
          //           decoration: BoxDecoration(
          //             // color: AppColor.gradientFirst,
          //             borderRadius: BorderRadius.circular(20),
          //             image: const DecorationImage(
          //               image: AssetImage("assets/images/mp3_meditating.png"),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           width: double.maxFinite,
          //           height: 85,
          //           margin: const EdgeInsets.only(top: 10, left: 100),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: const [
          //               AutoSizeText(
          //                 'MP3 တရားတော်များ',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                   // color: color.AppColor.homePageTitleColor,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () => pushNewScreen(context,
          //       screen: const MonkScreen(
          //         title: 'ဓမ္မပို့ချချက် MP3 တရားတော်များ',
          //       )),
          //   child: SizedBox(
          //     height: 85,
          //     width: MediaQuery.of(context).size.width,
          //     // color: AppColor.gradientFifth,
          //     child: Stack(
          //       children: [
          //         Container(
          //           alignment: Alignment.topLeft,
          //           width: MediaQuery.of(context).size.width,
          //           margin: const EdgeInsets.only(
          //             top: 10,
          //             left: 20,
          //             right: 20,
          //           ),
          //           height: 85,
          //           //color: AppColor.gradientFirst,
          //           decoration: BoxDecoration(
          //             color: Theme.of(context).scaffoldBackgroundColor,
          //             borderRadius: BorderRadius.circular(20),
          //             boxShadow: [
          //               BoxShadow(
          //                 blurRadius: 40,
          //                 offset: const Offset(8, 10),
          //                 color:
          //                     Theme.of(context).primaryColor.withOpacity(0.3),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           width: MediaQuery.of(context).size.width,
          //           height: 85,
          //           margin: const EdgeInsets.only(
          //             top: 10,
          //             left: 20,
          //             right: 220,
          //           ),
          //           decoration: BoxDecoration(
          //             // color: AppColor.gradientFirst,
          //             borderRadius: BorderRadius.circular(20),
          //             image: const DecorationImage(
          //               image: AssetImage("assets/images/meditation.png"),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           width: double.maxFinite,
          //           height: 85,
          //           margin: const EdgeInsets.only(top: 8, left: 100),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: const [
          //               AutoSizeText(
          //                 'ဓမ္မပို့ချချက်',
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   // color: color.AppColor.homePageTitleColor,
          //                 ),
          //               ),
          //               AutoSizeText(
          //                 'MP3 တရားတော်များ',
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   // color: color.AppColor.homePageTitleColor,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () => pushNewScreen(context,
          //       screen: const MonkScreen(
          //         title: 'ဓမ္မစာအုပ်များ',
          //         screenMode: MonkScreenMode.book,
          //       )),
          //   child: SizedBox(
          //     height: 85,
          //     width: MediaQuery.of(context).size.width,
          //     // color: AppColor.gradientFifth,
          //     child: Stack(
          //       children: [
          //         Container(
          //           alignment: Alignment.topLeft,
          //           width: MediaQuery.of(context).size.width,
          //           margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
          //           height: 85,
          //           //color: AppColor.gradientFirst,
          //           decoration: BoxDecoration(
          //             color: Theme.of(context).scaffoldBackgroundColor,
          //             borderRadius: BorderRadius.circular(20),
          //             boxShadow: [
          //               BoxShadow(
          //                 blurRadius: 40,
          //                 offset: const Offset(8, 10),
          //                 color:
          //                     Theme.of(context).primaryColor.withOpacity(0.3),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           width: MediaQuery.of(context).size.width,
          //           height: 85,
          //           margin: const EdgeInsets.only(
          //             top: 10,
          //             left: 20,
          //             right: 220,
          //           ),
          //           decoration: BoxDecoration(
          //             // color: AppColor.gradientFirst,
          //             borderRadius: BorderRadius.circular(20),
          //             image: const DecorationImage(
          //               image: AssetImage("assets/images/reading.png"),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           width: double.maxFinite,
          //           height: 85,
          //           margin: const EdgeInsets.only(top: 10, left: 100),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: const [
          //               AutoSizeText(
          //                 'ဓမ္မစာအုပ်များ',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                   // color: color.AppColor.homePageTitleColor,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Row(
            children: [
              GestureDetector(
                onTap: () => pushNewScreen(
                  context,
                  screen: const MonkScreen(
                    title: 'MP3 တရားတော်များ',
                    screenMode: MonkScreenMode.album,
                  ),
                ),
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 80,
                    minHeight: 80,
                    maxHeight: 80,
                  ),
                  width: (screenWidth - 50) / 2,
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 5),
                  padding: const EdgeInsets.all(5),
                  // height: 75,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        offset: const Offset(8, 10),
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.music_video,
                        size: 32,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                       FittedBox(
                        child: AutoSizeText(
                          'MP3 တရားတော်များ',
                          group: autoSizeGroup,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    pushNewScreen(context, screen: const RadioScreen()),
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 80,
                    minHeight: 80,
                    maxHeight: 80,
                  ),
                  width: (screenWidth - 50) / 2,
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 20),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  // height: 75,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        offset: const Offset(8, 10),
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.play_lesson_rounded,
                          size: 32,
                          color: Theme.of(context).primaryIconTheme.color),
                      const SizedBox(
                        height: 5,
                      ),
                       FittedBox(
                        child: AutoSizeText(
                          'ဓမ္မပို့ချချက်တရားတော်များ',
                          group: autoSizeGroup,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => pushNewScreen(context,
                    screen: const MonkScreen(
                      title: 'ဓမ္မစာအုပ်များ',
                      screenMode: MonkScreenMode.book,
                    )),
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 80,
                    minHeight: 80,
                    maxHeight: 80,
                  ),
                  width: (screenWidth - 50) / 2,
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 5),
                  padding: const EdgeInsets.all(5),
                  // height: 75,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        offset: const Offset(8, 10),
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Icon(
                      //   Icons.book_online_outlined,
                      //   size: 32,
                      //   color: Theme.of(context).primaryIconTheme.color,
                      // ),
                      ImageIcon(
                        const AssetImage('assets/images/book.jpeg'),
                        size: 32,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                       FittedBox(
                        child: AutoSizeText(
                          'ဓမ္မစာအုပ်များ',
                          group: autoSizeGroup,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    pushNewScreen(context, screen: const ChantingScreen()),
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 80,
                    minHeight: 80,
                    maxHeight: 80,
                  ),
                  width: (screenWidth - 50) / 2,
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 20),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  // height: 75,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        offset: const Offset(8, 10),
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageIcon(
                        const AssetImage('assets/images/prayer.png'),
                        size: 32,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                       FittedBox(
                        child: AutoSizeText(
                          'ဘုရားရှိခိုးနှင့်ဝတ်ရွတ်စဥ်',
                          group: autoSizeGroup,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () =>
                    pushNewScreen(context, screen: const YoutubeScreen()),
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 80,
                    minHeight: 80,
                    maxHeight: 80,
                  ),
                  width: (screenWidth - 50) / 2,
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 5),
                  padding: const EdgeInsets.all(5),
                  // height: 75,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        offset: const Offset(8, 10),
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.video_camera_front_outlined,
                        size: 32,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                       FittedBox(
                        child: AutoSizeText(
                          'Live Streaming',
                          group: autoSizeGroup,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    pushNewScreen(context, screen: const RadioScreen()),
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 80,
                    minHeight: 80,
                    maxHeight: 80,
                  ),
                  width: (screenWidth - 50) / 2,
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 20),
                  padding: const EdgeInsets.all(5),
                  // height: 75,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        offset: const Offset(8, 10),
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.radio_outlined,
                          size: 32,
                          color: Theme.of(context).primaryIconTheme.color),
                      const SizedBox(
                        height: 5,
                      ),
                      const FittedBox(
                        child: AutoSizeText(
                          'Online Radio',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const AutoSizeText(
            'တရားတော်အသစ်များ',
            style: TextStyle(
              fontSize: 18,
              // color: color.AppColor.homePageTitleColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const MonkCarousel(),
          const SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}
