import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/resourse/ColorsManager.dart';
import '../core/resourse/RouteManager.dart';

class CustomButton extends StatelessWidget {
  String title;
  Function()onPressed;
   CustomButton({super.key ,
    required this.title,
   required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),
            minimumSize: Size(double.infinity, 60),
        ),
        onPressed: (){
         onPressed();
        },
        child: Text(title.tr(),
            style:Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: ColorsManager.backgroundLight
            )));
  }
}
