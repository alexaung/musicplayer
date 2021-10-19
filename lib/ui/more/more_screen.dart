import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/root/root_screen.dart';
import 'package:thitsarparami/ui/setting/setting_screen.dart';

class MoreScreen extends StatefulWidget {
  static const routeName = '/more';
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Settings',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            Navigator.of(context).pushReplacementNamed(RootScreen.routeName);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(SettingScreen.routeName),
          ),
        ],
      ),
    );
  }
}
