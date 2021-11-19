import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:thitsarparami/ui/about/about_screen.dart';
import 'package:thitsarparami/ui/address/address_screan.dart';
import 'package:thitsarparami/ui/appointment/appointment_screen.dart';
import 'package:thitsarparami/ui/bio/bio_screen.dart';
import 'package:thitsarparami/ui/setting/setting_screen.dart';

class MoreScreen extends StatelessWidget {
  static const routeName = '/more';
  final BuildContext? menuScreenContext;
  final PersistentTabController? tabController;
  final Function? onScreenHideButtonPressed;
  final bool hideStatus;
  const MoreScreen(
      {Key? key,
      this.menuScreenContext,
      this.tabController,
      this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: AutoSizeText(
          'More',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            tabController!.jumpToTab(0);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryIconTheme.color!,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(
              Icons.person_outline_rounded,
              //size: 32,
            ),
            title: const AutoSizeText('သစ္စာပါရမီဆရာတော်ထေရုပ္ပတ္တိ'),
            onTap: () => pushNewScreen(context,
                screen: const BiographyScreen(),
                pageTransitionAnimation: PageTransitionAnimation.scale),
            // Navigator.of(context)
            //     .pushReplacementNamed(SettingScreen.routeName),
          ),
          ListTile(
            leading: const ImageIcon(
              AssetImage('assets/images/logo_icon.png'),
              //size: 32,
            ),
            title: const AutoSizeText('သစ္စာပါရမီဖြစ်ပေါ်လာရခြင်းအကြောင်း'),
            onTap: () => pushNewScreen(context,
                screen: const AboutScreen(),
                pageTransitionAnimation: PageTransitionAnimation.scale),
            // Navigator.of(context)
            //     .pushReplacementNamed(SettingScreen.routeName),
          ),
          ListTile(
            leading: const Icon(
              Icons.location_on_outlined,
              //size: 32,
            ),
            title: const AutoSizeText('သစ္စာပါရမီဘုန်းကြီးကျောင်းလိပ်စာ'),
            onTap: () => pushNewScreen(context,
                screen: const AddressScreen(),
                pageTransitionAnimation: PageTransitionAnimation.scale),
            // Navigator.of(context)
            //     .pushReplacementNamed(SettingScreen.routeName),
          ),
          ListTile(
            leading: const Icon(
              Icons.calendar_today_outlined,
              //size: 32,
            ),
            title: const AutoSizeText('ဆွမ်းစားပင့်လျောက်ရန် (စင်ကာပူသီးသန့်)'),
            onTap: () => pushNewScreen(context,
                screen: const AppointmentScreen(),
                pageTransitionAnimation: PageTransitionAnimation.scale),
            // Navigator.of(context)
            //     .pushReplacementNamed(SettingScreen.routeName),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings_outlined,
              //size: 32,
            ),
            title: const AutoSizeText('ဆက်တင်'),
            onTap: () => pushNewScreen(context,
                screen: const SettingScreen(),
                pageTransitionAnimation: PageTransitionAnimation.scale),
            // Navigator.of(context)
            //     .pushReplacementNamed(SettingScreen.routeName),
          ),
        ],
      ),
    );
  }
}
