import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OnboardingItems extends StatelessWidget {
  List<Map<String, String>>onboarding=[{}];
  int index;
   OnboardingItems({super.key, required this.onboarding,
   required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(onboarding[index]['image']!),
        Text(onboarding[index]['title']!.tr(),
        style: Theme.of(context).textTheme.headlineLarge),

        Text(onboarding[index]['subtitle']!.tr(),
          style:Theme.of(context).textTheme.titleMedium,)
      ],
    );
  }
}
