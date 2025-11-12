import 'package:evently_app/core/providers/UserProvider.dart';
import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/core/resourse/RouteManager.dart';
import 'package:evently_app/screens/home/tabs/HomeTap/home_tab.dart';
import 'package:evently_app/screens/home/tabs/LoveTab/love_tab.dart';
import 'package:evently_app/screens/home/tabs/MapTab/map_tab.dart';
import 'package:evently_app/screens/home/tabs/ProfileTab/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/LocationProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).GetUser();
  }

  int selectedTab = 0;

  List<Widget> tabs = [
    HomeTab(),
    ChangeNotifierProvider(
      create: (context) => LocationProvider()
        ..getLocation()..getAllEvents(),
      child: MapTab(),
    ),
    LoveTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteManager.addEvent);
        },
        child: Icon(Icons.add, size: 35),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 2) return;
          setState(() {
            selectedTab = index > 2 ? index - 1 : index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsManager.home)),
            label: 'Home',
            backgroundColor: Theme.of(
              context,
            ).bottomNavigationBarTheme.backgroundColor,
            activeIcon: ImageIcon(AssetImage(AssetsManager.home_selected)),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsManager.map)),
            label: 'Map',
            activeIcon: ImageIcon(AssetImage(AssetsManager.map_selected)),
          ),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsManager.love)),
            label: 'Love',
            activeIcon: ImageIcon(AssetImage(AssetsManager.love_selected)),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsManager.profile)),
            label: 'Profile',
            activeIcon: ImageIcon(AssetImage(AssetsManager.profile_selected)),
          ),
        ],
        currentIndex: selectedTab >= 2 ? selectedTab + 1 : selectedTab,
      ),
      body: tabs[selectedTab],
    );
  }
}
