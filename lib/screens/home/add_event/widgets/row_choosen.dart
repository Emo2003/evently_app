import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resourse/AssetsManager.dart';
import '../../../../core/resourse/ColorsManager.dart';

class EventDateAndTime extends StatelessWidget {
  final String title;
 final  String choose;
 final String image;
 final Function()onPressed;
  const EventDateAndTime({super.key,
  required this.title,
    required this.onPressed,
    required this.image,
  required this.choose,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        SvgPicture.asset(image),
        SizedBox(width: 10,),
        Expanded(
          child: Text(title, style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorsManager.black),),
        ),
        TextButton(
            onPressed: (){
              onPressed();
            },
            child: Text(choose, style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorsManager.blue,
            ),
            ))
      ],
    );
  }
}
