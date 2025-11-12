import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/providers/ThemeProvider.dart';
import 'package:evently_app/core/providers/UserProvider.dart';
import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:evently_app/core/resourse/RouteManager.dart';
import 'package:evently_app/screens/CustomButton.dart';
import 'package:evently_app/screens/home/widgets/CustomDropDownButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/resourse/PrefsManager.dart';
import '../../../../services/fire_base_services.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String selectedLanguage = "en";
  String selectedTheme = "light";

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    if (themeProvider.mode == ThemeMode.light) {
      selectedTheme = "light";
    } else {
      selectedTheme = "dark";
    }
    selectedLanguage = context.locale.languageCode;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 210,
          decoration: BoxDecoration(
            color: ColorsManager.blue,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: ColorsManager.backgroundLight,
                      image: DecorationImage(
                        image: AssetImage(AssetsManager.imageProfile),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(1000),
                        bottomRight: Radius.circular(1000),
                        bottomLeft: Radius.circular(1000),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.user!.name!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.backgroundLight,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          provider.user!.email!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.backgroundLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Language",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                CustomDropDownButton(
                  value: selectedLanguage,
                  onChange: (String? value) {
                    setState(() {
                      selectedLanguage = value!;
                    });
                    if (selectedLanguage == "en") {
                      context.setLocale(Locale("en"));
                    } else {
                      context.setLocale(Locale("ar"));
                    }
                  },
                  value1: "en",
                  value2: "ar",
                  item1: "English",
                  item2: "العربية",
                ),
                SizedBox(height: 20),
                Text(
                  "Theme",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                CustomDropDownButton(
                  value: selectedTheme,
                  onChange: (String? value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                    if (selectedTheme == "light") {
                      themeProvider.changeTheme(ThemeMode.light);
                      PrefsManager.setTheme(ThemeMode.light);
                    } else {
                      themeProvider.changeTheme(ThemeMode.dark);
                      PrefsManager.setTheme(ThemeMode.dark);
                    }
                  },
                  value1: "light",
                  value2: "dark",
                  item1: "Light",
                  item2: "Dark",
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    minimumSize: Size(double.infinity, 60),
                  ),
                  onPressed: () async{
                    await FirebaseServices().googleSignOut();
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(context, RouteManager.login, (route) => false);
                  },
                  child:Row(
                    children: [
                      Icon(Icons.logout_outlined,color: Colors.white,size: 30,),
                      SizedBox(width: 8,),
                      Text("Logout", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),),

                    ],
                  ),
                ),
                SizedBox(height: 15,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
