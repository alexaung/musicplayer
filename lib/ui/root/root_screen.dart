import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/settings/preferences.dart';
import 'package:thitsarparami/ui/album/album_screen.dart';
import 'package:thitsarparami/ui/home/home_screen.dart';
import 'package:thitsarparami/ui/monk/monk_screen.dart';
import 'package:thitsarparami/ui/more/more_screen.dart';
import 'package:thitsarparami/ui/setting/setting_screen.dart';
import 'package:thitsarparami/ui/song/song_screen.dart';

BuildContext? testContext;

class RootScreen extends StatefulWidget {
  static const routeName = '/';
  final BuildContext menuScreenContext;
  const RootScreen({Key? key, required this.menuScreenContext})
      : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  PersistentTabController? _controller;
  bool _hideNavBar = false;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
    _loadTheme();
  }

  _loadTheme() async {
    BlocProvider.of<ThemeBloc>(context)
        .add(ThemeEvent(appTheme: Preferences.getTheme()));
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      HomeScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      HomeScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MoreScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: "Home",
        activeColorPrimary:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColorPrimary:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        inactiveColorSecondary: Theme.of(context).primaryColorLight,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/monk': (context) => const MonkScreen(),
            '/album': (context) => const AlbumScreen(),
            '/song': (context) => const SongScreen(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.create_new_folder_outlined),
        title: ("Library"),
        activeColorPrimary:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColorPrimary:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        inactiveColorSecondary: Theme.of(context).primaryColorLight,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: '/',
        //   routes: {
        //     '/monk': (context) => const MonkScreen(),
        //     '/album': (context) => const AlbumScreen(),
        //   },
        // ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.play_circle_outlined),
        title: ("Play"),
        activeColorPrimary:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColorPrimary:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        inactiveColorSecondary: Theme.of(context).primaryColorLight,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: '/',
        //   routes: {
        //     '/first': (context) => MainScreen2(),
        //     '/second': (context) => MainScreen3(),
        //   },
        // ),
        // onPressed: (context) {
        //   pushDynamicScreen(context,
        //       screen: SampleModalScreen(), withNavBar: true);
        // },
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.more_horiz_outlined),
        title: ("More"),
        activeColorPrimary:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColorPrimary:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        inactiveColorSecondary: Theme.of(context).primaryColorLight,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/settings': (context) => const SettingScreen(),
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).backgroundColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: const EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        // onWillPop: (context) async {
        //   await showDialog(
        //     context: context!,
        //     useSafeArea: true,
        //     builder: (context) => Container(
        //       height: 50.0,
        //       width: 50.0,
        //       color: Colors.white,
        //       child: ElevatedButton(
        //         child: const Text("Close"),
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ),
        //   );
        //   return false;
        // },
        selectedTabScreenContext: (context) {
          testContext = context;
        },
        hideNavigationBar: _hideNavBar,
        decoration: const NavBarDecoration(
            border: Border(
                top: BorderSide(
                    color: Colors.grey, width: 0.2, style: BorderStyle.solid))
            // colorBehindNavBar: Colors.grey,
            // boxShadow: [
            //   BoxShadow(
            //     blurRadius: 40,
            //     offset: Offset(8, 10),
            //     //color: Color(0xFFEEEEEE),
            //     color: Theme.of(context).primaryColor!,
            //   ),
            // ],
            // borderRadius: BorderRadius.circular(20.0),
            ),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.slowMiddle,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style1, // Choose the nav bar style with this property
      ),
    );
  }
}
