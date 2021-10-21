import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/ui/setting/setting_screen.dart';

class MoreScreen extends StatelessWidget {
  static const routeName = '/more';
  final BuildContext? menuScreenContext;
  final Function? onScreenHideButtonPressed;
  final bool hideStatus;
  const MoreScreen(
      {Key? key,
      this.menuScreenContext,
      this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        // centerTitle: true,
        title: Text(
          'More',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     pushNewScreenWithRouteSettings(
        //               context,
        //               settings: const RouteSettings(name: '/home'),
        //               screen: RootScreen(menuScreenContext: widget.menuScreenContext!,),
        //               pageTransitionAnimation:
        //                   PageTransitionAnimation.scaleRotate,
        //             );
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back,
        //   ),
        // ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () => pushNewScreen(context, screen: const SettingScreen()),
            // Navigator.of(context)
            //     .pushReplacementNamed(SettingScreen.routeName),
          ),
        ],
      ),
    );
  }
}
