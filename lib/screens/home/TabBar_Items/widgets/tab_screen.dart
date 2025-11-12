import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:evently_app/models/EventModel.dart';
import 'package:flutter/material.dart';

import '../../../../core/resourse/AppConstant.dart';

class TabScreen extends StatefulWidget {
 final Event event;
  const TabScreen({super.key,
  required this.event});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  bool selectedIndex = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal:  16.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(typeImage[widget.event.type]!),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorsManager.backgroundLight,
                  borderRadius: BorderRadius.all(Radius.circular(8),),),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.event.dateTime!.toDate().day.toString(), style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorsManager.blue),),
                    Text(DateFormat.MMM().format(widget.event.dateTime!.toDate()), style: TextStyle(fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: ColorsManager.blue),),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorsManager.backgroundLight,
                  borderRadius: BorderRadius.all(Radius.circular(8),),),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(widget.event.description.toString(), style:
                      TextStyle(fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: ColorsManager.black,
                     ), maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          selectedIndex=!selectedIndex;
                        });
                      },
                        child: Image.asset(
                          selectedIndex
                              ? "assets/images/selectedLove.png"
                              :"assets/images/love.png",
                        ))

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
