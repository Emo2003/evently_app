import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/resourse/RouteManager.dart';
import 'package:evently_app/core/providers/ThemeProvider.dart';
import 'package:evently_app/screens/onboarding_start/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/resourse/AssetsManager.dart';
import '../../core/resourse/PrefsManager.dart';
import '../CustomButton.dart';

class OnboardingStart extends StatefulWidget {
  const OnboardingStart({super.key});

  @override
  State<OnboardingStart> createState() => _OnboardingStartState();
}

class _OnboardingStartState extends State<OnboardingStart> {
  String selectedLanguage = "en";
  String selectedTheme = "light";

  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode;
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    if (provider.mode == ThemeMode.light) {
      selectedTheme = "light";
    } else {
      selectedTheme = "dark";
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  AssetsManager.barLogo,
                  height: 60,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(height: 28),
              Image.asset(AssetsManager.creative2),
              SizedBox(height: 28),
              Text(
                "title_start".tr(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 28),
              Text(
                "sub_start".tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Text(
                    "language".tr(),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  CustomSwitch(
                    values: ["en", "ar"],
                    current: selectedLanguage,
                    icon1: AssetsManager.america,
                    icon2: AssetsManager.egypt,
                    onChange: (value) {
                      setState(() {
                        selectedLanguage = value;
                      });
                      if (selectedLanguage == "ar") {
                        context.setLocale(Locale("ar"));
                      } else {
                        context.setLocale(Locale("en"));
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "theme".tr(),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  CustomSwitch(
                    isColored: true,
                    values: ["light", "dark"],
                    current: selectedTheme,
                    icon1: AssetsManager.sun,
                    icon2: AssetsManager.moon,
                    onChange: (value) {
                      setState(() {
                        selectedTheme = value;
                        if (selectedTheme == "dark") {
                          provider.changeTheme(ThemeMode.dark);
                          PrefsManager.setTheme(ThemeMode.dark);
                        } else {
                          provider.changeTheme(ThemeMode.light);
                          PrefsManager.setTheme(ThemeMode.light);
                        }
                      });
                    },
                  ),
                ],
              ),
              Spacer(),
              CustomButton(
                title: "lets_start",
                onPressed: () async {
                  await PrefsManager.setStart(true);
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(RouteManager.onboarding);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
