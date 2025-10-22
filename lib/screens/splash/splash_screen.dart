import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF2FEFF),
      body: SafeArea(
        child: Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(AssetsManager.logo, height: height*0.25,
              alignment: Alignment.bottomCenter,
            ),
          ).animate()
              .fadeIn(duration: Duration(milliseconds: 800))
              .scale(
            duration: Duration(milliseconds: 700),
            curve: Curves.easeOutBack,
            begin: const Offset(0.5, 0.5),
            end: const Offset(1, 1),
          )
              .move(begin: const Offset(0, 50), end: Offset.zero)
              .blurXY(begin: 4, end: 0),

          Spacer(),
          Image.asset(AssetsManager.branding)
        ],
        ),
      ),
    );
  }
}
