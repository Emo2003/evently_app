import 'package:evently_app/core/providers/UserProvider.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:evently_app/screens/home/TabBar_Items/all_bar.dart';
import 'package:evently_app/screens/home/TabBar_Items/birthday_bar.dart';
import 'package:evently_app/screens/home/TabBar_Items/book_club_bar.dart';
import 'package:evently_app/screens/home/TabBar_Items/sport_bar.dart';
import 'package:evently_app/screens/home/TabBar_Items/widgets/tab_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);

    return DefaultTabController(
      length: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Container(
            width: double.infinity,
            height: 207,
            decoration: const BoxDecoration(
              color: ColorsManager.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back ✨",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.backgroundLight,
                      ),
                    ),
                    provider.user == null
                        ? const Center(child: CircularProgressIndicator(color: ColorsManager.backgroundLight,))
                        : Text(
                      provider.user!.name!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: ColorsManager.backgroundLight,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: ColorsManager.backgroundLight,
                          size: 25,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Cairo , Egypt",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.backgroundLight,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TabBar(
                      tabAlignment: TabAlignment.start,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.only(right: 20),
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      isScrollable: true,
                      onTap: (value) {
                        setState(() {
                          selectedIndex = value;
                        });
                      },
                      tabs: [
                        TabItems(
                            image: "assets/images/all.svg",
                            title: "All",
                            colorText: selectedIndex == 0 ?
                            ColorsManager.blue
                            :ColorsManager.backgroundLight,
                            color:ColorFilter.mode(
                                selectedIndex == 0 ?
                                ColorsManager.blue
                                :ColorsManager.backgroundLight,
                                BlendMode.srcIn ,
                                ),
                            colorContainer:
                            selectedIndex == 0 ?
                             ColorsManager.backgroundLight
                            :Colors.transparent,),
                        TabItems(
                            image: "assets/images/bike.svg",
                            title: "Sport",
                            colorText: selectedIndex == 1?
                            ColorsManager.blue
                            :ColorsManager.backgroundLight,
                            color:ColorFilter.mode(
                                selectedIndex == 1 ?
                                ColorsManager.blue
                                :ColorsManager.backgroundLight,
                                BlendMode.srcIn ,
                                ),
                            colorContainer:
                            selectedIndex == 1 ?
                             ColorsManager.backgroundLight
                            :Colors.transparent,),
                        TabItems(
                            image: "assets/images/cake.svg",
                            title: "BirthDay",
                            colorText: selectedIndex == 2?
                            ColorsManager.blue
                            :ColorsManager.backgroundLight,
                            color:ColorFilter.mode(
                                selectedIndex == 2 ?
                                ColorsManager.blue
                                :ColorsManager.backgroundLight,
                                BlendMode.srcIn ,
                                ),
                            colorContainer:
                            selectedIndex == 2 ?
                             ColorsManager.backgroundLight
                            :Colors.transparent,),
                        TabItems(
                            svgPicture: false,
                            icon:Icons.menu_book_outlined ,
                           colorIcon: selectedIndex==3?
                          ColorsManager.blue
                          :ColorsManager.backgroundLight,
                            title: "BookClub",
                            colorText: selectedIndex == 3?
                            ColorsManager.blue
                            :ColorsManager.backgroundLight,
                            color:ColorFilter.mode(
                                selectedIndex == 3 ?
                                ColorsManager.blue
                                :ColorsManager.backgroundLight,
                                BlendMode.srcIn ,
                                ),
                            colorContainer:
                            selectedIndex == 3 ?
                             ColorsManager.backgroundLight
                            :Colors.transparent,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [AllBar(), SportBar(), BirthdayBar(), BookClubBar()],
            ),
          ),
        ],
      ),
    );
  }
}
