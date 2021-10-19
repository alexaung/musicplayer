import 'package:flutter/material.dart';
import 'package:thitsarparami/ui/home/home_screen.dart';
import 'package:thitsarparami/ui/more/more_screen.dart';
import 'package:thitsarparami/widgets/custom_bottom_navigation_bar.dart';

class RootScreen extends StatefulWidget {
  static const routeName = '/';
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;
  final screens = [
    Center(child: HomeScreen()),
    const Center(child: Text('Library')),
    const Center(child: Text('Play')),
    const Center(child: MoreScreen()),
  ];

  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: currentIndex, onTap: onTap),
    );
  }
}
