import 'package:evently_app/core/providers/UserProvider.dart';
import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/screens/home/tabs/home_tab.dart';
import 'package:evently_app/screens/home/tabs/love_tab.dart';
import 'package:evently_app/screens/home/tabs/map_tab.dart';
import 'package:evently_app/screens/home/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  int selectedTab= 0 ;
  List<Widget>tabs=[
    HomeTab(),
    MapTab(),
    LoveTab(),
    ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
      child: Icon(Icons.add, size: 35,),
     ),
   bottomNavigationBar: BottomNavigationBar(
     onTap: (index) {
     if (index == 2) return;
     setState(() {
       selectedTab = index > 2 ? index -1 : index;
     });
   },
    items:[
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AssetsManager.home))
          ,label: 'Home',
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        activeIcon: ImageIcon(AssetImage(AssetsManager.home_selected))
      ),
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AssetsManager.map)),
          label: 'Map',
          activeIcon: ImageIcon(AssetImage(AssetsManager.map_selected))

      ),
       BottomNavigationBarItem(
        icon: SizedBox.shrink(),
        label: '',
      ),
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AssetsManager.love))
          ,label: 'Love',
          activeIcon: ImageIcon(AssetImage(AssetsManager.love_selected))

      ),
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AssetsManager.profile))
          ,label: 'Profile',
          activeIcon: ImageIcon(AssetImage(AssetsManager.profile_selected))

      ),
    ],
     currentIndex: selectedTab >= 2 ? selectedTab + 1 : selectedTab,
   ),
    body: tabs[selectedTab],
    );


  }
}

