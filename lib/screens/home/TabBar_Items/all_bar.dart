import 'package:evently_app/core/resourse/RouteManager.dart';
import 'package:evently_app/screens/home/TabBar_Items/widgets/tab_screen.dart';
import 'package:evently_app/services/Firebase_storageManager.dart';
import 'package:flutter/material.dart';

import '../../../core/resourse/ColorsManager.dart';
import '../../../models/EventModel.dart';

class AllBar extends StatelessWidget {
  const AllBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorageManager.getAllEvent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: ColorsManager.blue),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        List<Event> event = snapshot.data!;
        return ListView.separated(
            separatorBuilder: (_, _) => SizedBox(height: 20),
            itemCount: event.length,
          itemBuilder: (_, index) {
            final currentEvent = event[index];
       return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      RouteManager.eventDetails,
                      arguments: currentEvent,
                    );
                  },
                  child: TabScreen(event: event[index]));},
        );
      },
    );
  }
}
