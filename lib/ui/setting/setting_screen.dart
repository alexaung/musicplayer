import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:thitsarparami/settings/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/blocs/theme/theme_bloc.dart';
import 'package:thitsarparami/blocs/theme/theme_event.dart';
import 'package:thitsarparami/settings/preferences.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/settings';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  _loadTheme() async {
    BlocProvider.of<ThemeBloc>(context)
        .add(ThemeEvent(appTheme: Preferences.getTheme()));
  }

  _setTheme(bool darkTheme) {
    AppTheme selectedTheme = darkTheme ? AppTheme.light : AppTheme.dark;
    BlocProvider.of<ThemeBloc>(context)
        .add(ThemeEvent(appTheme: selectedTheme));
    Preferences.saveTheme(selectedTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Settings',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const RootScreen()),
            // );
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryIconTheme.color!,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.mode_night_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    buidCupertinoSwitch(
                      context,
                      Preferences.getTheme() == AppTheme.light
                          ? 'Light'
                          : 'Dark',
                      Preferences.getTheme() == AppTheme.light,
                      _setTheme,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Theme.of(context).primaryColor)),
              child: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData
                        ? ('Version: ' +
                            snapshot.data!.version +
                            '.' +
                            snapshot.data!.buildNumber)
                        : '',
                    style: const TextStyle(color: Colors.black),
                  );
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}

Padding buidCupertinoSwitch(
    BuildContext context, String title, bool value, Function onChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 20,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            activeColor: Theme.of(context).primaryColor,
            value: value,
            onChanged: (bool newValue) {
              onChanged(newValue);
            },
          ),
        ),
      ],
    ),
  );
}

// GestureDetector buidMenuOption(BuildContext context, sting title