import 'package:evently_app/core/resourse/PrefsManager.dart';
import 'package:evently_app/core/resourse/RouteManager.dart';
import 'package:flutter/material.dart';

import '../../../core/resourse/ColorsManager.dart';

class BottomNav extends StatelessWidget {
  int currentIndex;
  Function() next;
  Function() previous;
  List<Map<String,String>>onBoarding=[{}];

   BottomNav({super.key,
  required this.currentIndex,
  required this.next,
  required this.previous,
   required this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        currentIndex>0?
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Color(0xff5669FF)),
            borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          child: IconButton(
              onPressed: (){
                previous();
              },
            icon:  Icon(Icons.arrow_back , size: 30,),
            color:Color(0xff5669FF),),
        ):SizedBox(),
    Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      children:List.generate(onBoarding.length,
            (index) {
      bool isActive = currentIndex==index;
      return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4),
         width: isActive?28 :10,
         height: 10,
         decoration: BoxDecoration(
         color: isActive? Theme.of(context).colorScheme.secondary: Theme.of(context).colorScheme.primary,
         borderRadius: BorderRadius.circular(36)
      ),
      );
      },),),
    ),

        Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: ColorsManager.blue),
              borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          child: IconButton( onPressed:
          currentIndex==onBoarding.length-1?
           ( )async{
           await PrefsManager.setItems(true);
            Navigator.of(context).pushReplacementNamed(RouteManager.login);}
             :next,
            icon:  Icon(Icons.arrow_forward, size: 30,)
              ,color:Color(0xff5669FF)),
        )
      ],
    );
  }
}
