// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'components/header.dart';
import 'components/menu.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  
  @override
  void initState() {
    super.initState();
    // _loadTheme();
  }

  // _loadTheme() async {
  //   BlocProvider.of<ThemeBloc>(context)
  //       .add(ThemeEvent(appTheme: Preferences.getTheme()));
  // }

  // _setTheme(bool darkTheme) {
  //   AppTheme selectedTheme = darkTheme ? AppTheme.light : AppTheme.dark;
  //   BlocProvider.of<ThemeBloc>(context)
  //       .add(ThemeEvent(appTheme: selectedTheme));
  //   Preferences.saveTheme(selectedTheme);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColorDark,
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColorLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   actions: [
        //     Switch(
        //       value: Preferences.getTheme() == AppTheme.light,
        //       onChanged: _setTheme,
        //     )
        //   ],
        // ),
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
        // bottomNavigationBar: const CustomBottomNavigationBar(cuttentIndex: currentIndex),
      ),
    );
  }
}
