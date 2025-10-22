import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/AppStyle.dart';
import 'package:evently_app/core/resourse/PrefsManager.dart';
import 'package:evently_app/core/resourse/RouteManager.dart';
import 'package:evently_app/core/resourse/ThemeProvider.dart';
import 'package:evently_app/screens/login/login_screen.dart';
import 'package:evently_app/screens/onboarding/onboarding_screen.dart';
import 'package:evently_app/screens/onboarding_start/onboarding_start.dart';
import 'package:evently_app/screens/register/register_screen.dart';
import 'package:evently_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsManager.init();
  bool seen = PrefsManager.getItems();
  bool start = PrefsManager.getStart();
  runApp(EasyLocalization(
    supportedLocales: [
      Locale("en"),
      Locale("ar"),
    ],
    path:'assets/translation' ,
    fallbackLocale: Locale("en"),
    startLocale: Locale("en"),
    child: ChangeNotifierProvider(
      create: (context)=>ThemeProvider(),
      child: EventlyApp(
        seenOnBoarding: seen,
        onBoardingStart:start ,),
    ),
  ));
}
class EventlyApp extends StatelessWidget {
  bool seenOnBoarding ;
  bool onBoardingStart;
   EventlyApp({super.key,
     required this.seenOnBoarding,
     required this.onBoardingStart});
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider =Provider.of<ThemeProvider>(context);

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppStyle.light,
      darkTheme: AppStyle.dark,
      themeMode: provider.mode,
      initialRoute:RouteManager.onboarding_start,
      routes: {
        RouteManager.splash:(context)=>SplashScreen(),
        RouteManager.register:(context)=>RegisterScreen(),
        RouteManager.login:(context)=>LoginScreen(),
        RouteManager.onboarding:(context)=>OnboardingScreen(),
        RouteManager.onboarding_start:(context)=>OnboardingStart()
      },

    );
  }
}
enum FieldType { name, email, password, rePassword }


