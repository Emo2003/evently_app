import 'package:evently_app/screens/home/TabBar_Items/widgets/tab_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/resourse/ColorsManager.dart';
import '../../../core/resourse/RouteManager.dart';
import '../../../models/EventModel.dart';
import '../../../services/Firebase_storageManager.dart';

class BookClubBar extends StatelessWidget {
  const BookClubBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseStorageManager.getTypeEvent("BookClub"),
        builder: (context, snapshot) {
          if(snapshot.connectionState== ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: ColorsManager.blue,));
          }
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }
          List<Event> event = snapshot.data!;
          return   ListView.separated(
              itemBuilder: (_, index) {
                final currentEvent = event[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteManager.eventDetails,
                        arguments: currentEvent,
                      );
                    },
                    child: TabScreen(event: event[index]));} ,
              separatorBuilder: (_,_)=> SizedBox(height: 20,),
              itemCount:event.length );

        }
    );
  }
}
