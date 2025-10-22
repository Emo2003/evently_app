import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:evently_app/screens/onboarding/widgets/List_Of_Items.dart';
import 'package:evently_app/screens/onboarding/widgets/bottomNav.dart';
import 'package:evently_app/screens/onboarding/widgets/onboarding_items.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller=PageController();
  int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,
          horizontal: 16),
          child: Column(
            children: [
              Center(
                child: Image.asset(AssetsManager.barLogo, height: 60,
                  fit: BoxFit.fitHeight,
                           ),
              ),        SizedBox(height: 38,),

              Expanded(
                child: PageView.builder(
                  controller: controller ,
                  itemBuilder:(_,index)=>OnboardingItems(
                    onboarding:dataOnBoarding ,
                    index: index,) ,
                itemCount: dataOnBoarding.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },),
              ),
              BottomNav(currentIndex: currentIndex,
              onBoarding:dataOnBoarding,
              previous:goToPrevious ,
              next:goToNext ,)
            ],
          ),
        ),
      ),
    );
  }
  goToPrevious(){
    if (currentIndex > 0) {
      controller.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
  goToNext(){
    if(currentIndex<dataOnBoarding.length-1){
      controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }

  }
}
