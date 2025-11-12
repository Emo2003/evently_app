import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/resourse/AppStyle.dart';
import 'package:evently_app/core/resourse/PrefsManager.dart';
import 'package:evently_app/core/resourse/RouteManager.dart';
import 'package:evently_app/core/providers/ThemeProvider.dart';
import 'package:evently_app/screens/forget_password/screen/forget_pass_screen.dart';
import 'package:evently_app/screens/home/add_event/add_event_screen.dart';
import 'package:evently_app/screens/home/add_event/choose_event_location.dart';
import 'package:evently_app/screens/home/edit_event/edit_event_screen.dart';
import 'package:evently_app/screens/home/event_details/events_details_screen.dart';
import 'package:evently_app/screens/home/home_screen.dart';
import 'package:evently_app/screens/home/tabs/MapTab/widgets/list_of_event.dart';
import 'package:evently_app/screens/login/login_screen.dart';
import 'package:evently_app/screens/onboarding/onboarding_screen.dart';
import 'package:evently_app/screens/onboarding_start/onboarding_start.dart';
import 'package:evently_app/screens/register/register_screen.dart';
import 'package:evently_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/providers/CreateEventProvider.dart';
import 'core/providers/UserProvider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PrefsManager.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  bool seen = PrefsManager.getItems();
  bool start = PrefsManager.getStart();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale("en"), Locale("ar")],
      path: 'assets/translation',
      fallbackLocale: Locale("en"),
      saveLocale: true,
      startLocale: Locale("en"),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider()..init(),
        child: EventlyApp(seenOnBoarding: seen, onBoardingStart: start),
      ),
    ),
  );
}

class EventlyApp extends StatelessWidget {
  bool seenOnBoarding;

  bool onBoardingStart;

  EventlyApp({
    super.key,
    required this.seenOnBoarding,
    required this.onBoardingStart,
  });

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppStyle.light,
      darkTheme: AppStyle.dark,
      themeMode: provider.mode,
      initialRoute: onBoardingStart == false
          ? RouteManager.onboarding_start
          : (seenOnBoarding == false
                ? RouteManager.onboarding
                : RouteManager.login),
      routes: {
        RouteManager.splash: (context) => SplashScreen(),
        RouteManager.register: (context) => RegisterScreen(),
        RouteManager.login: (context) => LoginScreen(),
        RouteManager.onboarding: (context) => OnboardingScreen(),
        RouteManager.onboarding_start: (context) => OnboardingStart(),
        RouteManager.forgetpass: (context) => ForgetPassScreen(),
        RouteManager.eventDetails: (context) => EventDetailsScreen(),
        RouteManager.editEvent: (context) => ChangeNotifierProvider(
            create: (context) => CreateEventProvider(),
            child: EditEventScreen()),
        RouteManager.addEvent: (context) => ChangeNotifierProvider(
            create: (BuildContext context) =>CreateEventProvider(),
            child: AddEventScreen()),
        RouteManager.chooseLocation: (context) {
          CreateEventProvider provider =
          ModalRoute.of(context)?.settings.arguments as CreateEventProvider;
          return ChooseEventLocationScreen(provider: provider);},
        RouteManager.home: (context) => ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: HomeScreen(),
        ),
      },
    );
  }
}

