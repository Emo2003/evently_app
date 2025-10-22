import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSwitch extends StatelessWidget {
  String current;
 Function(String) onChange;
  List<String>values;
  String icon1;
  String icon2;
  bool isColored;
   CustomSwitch({super.key, required this.icon2,
     this.isColored=false,
  required this.icon1,
  required this.current,
     required this.onChange,
  required this.values});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: AnimatedToggleSwitch<String>.rolling(
        onChanged: onChange,
          current: current,
          values:values,
          iconList: [SvgPicture.asset(
           icon1,
          width: 32,
            height: 32,
            colorFilter: isColored
                ? ColorFilter.mode(
               current=="light"
                   ? ColorsManager.text_dark
                   :Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn)
                :null
          ),
            SvgPicture.asset(
                icon2,
                width: 32,
                height: 32,
              colorFilter: isColored
                  ? ColorFilter.mode(
                  current=="dark"
                      ? Theme.of(context).colorScheme.primary
                      :Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn)
                  :null
            )],
        style: ToggleStyle(
          backgroundColor: Colors.transparent,
          indicatorColor: ColorsManager.blue,
          borderColor: ColorsManager.blue,
        ),
        iconOpacity: 1,
        indicatorSize: Size.fromRadius(19),
        spacing: 20.0,
      ),
    );
  }
}
