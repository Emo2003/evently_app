import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resourse/ColorsManager.dart';

class TabItems extends StatelessWidget {
 final int? selectedIndex;
 final String title;
 final Color colorText;
 final Color colorContainer;
 final ColorFilter color;
 final bool? svgPicture;
 final IconData? icon;
 final String? image;
final bool? CreateEvent;
 final Color? colorIcon;
  const TabItems({super.key,
    this.CreateEvent=false,
    this.selectedIndex,required this.title,
   required this.colorText,
    this.colorIcon,
   required this.color,
     required this.colorContainer,
     this.svgPicture=true,
     this.icon, this.image});

  @override
  Widget build(BuildContext context) {
    return
        Tab(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: colorContainer,
              border: Border.all(
                color: CreateEvent==false
                    ? ColorsManager.backgroundLight
                    :ColorsManager.blue,
              ),
              borderRadius: BorderRadius.circular(46),
            ),
            child: Row(
              children: [
                svgPicture==false?
                   Icon(icon,
                     color:colorIcon,
                     size: 22,)
                :SvgPicture.asset( image! ,
                  colorFilter:color,),
                SizedBox(width: 8),
                Text(title, style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:colorText
                ),),
              ],
            ),
          ),
    );
  }
}
