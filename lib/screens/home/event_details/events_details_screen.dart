import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/resourse/AppConstant.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:evently_app/core/resourse/DialogUtils.dart';
import 'package:evently_app/core/resourse/RouteManager.dart';
import 'package:evently_app/screens/home/add_event/widgets/custom_outlined_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/EventModel.dart';
import '../../../services/Firebase_storageManager.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late Event event;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Event) {
      event = args;
    }
  }
  @override
  Widget build(BuildContext context) {
    Event event = ModalRoute.of(context)?.settings.arguments as Event;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final LatLng eventLatLng = LatLng(
      event.latitude ?? 0,
      event.longitude ?? 0,
    );
    String formattedDate = "";
    String formattedTime = "";
    if (event.dateTime != null) {
      final date = event.dateTime!.toDate();
      formattedDate =
          "${date.day} ${DateFormat.MMMM().format(date)} ${date.year}";
      formattedTime = DateFormat.jm().format(date);
    }
    return Scaffold(
      appBar: AppBar(
        actions: FirebaseAuth.instance.currentUser!.uid == event.userId
            ? <Widget>[
          IconButton(
            onPressed: () async {
              // تأجيل فتح الصفحة بعد انتهاء الـ build الحالي
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                final updatedEvent = await Navigator.pushNamed(
                  context,
                  RouteManager.editEvent,
                  arguments: event,
                );

                if (updatedEvent is Event) {
                  if (!mounted) return;
                  setState(() {
                    event = updatedEvent;
                  });
                }
              });
            },
            icon: Icon(Icons.edit_outlined, color: ColorsManager.blue),
          ),


          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () async {
              bool confirm = DialogUtils.DialogMessage(
                  content: "Are you sure you want to delete this event?",
                  message: "Confirm Delete",
                  positiveOnPressed: () => Navigator.pop(context, false),
                  positiveButtonText: "Cancel",
                  negativeOnPressed: ()async {
                    await FirebaseStorageManager.deleteEvent(event.id!);
                    DialogUtils.toastMessage("Event deleted successfully");
                    Navigator.pushNamed(context, RouteManager.home);
                  },
                  negativeButtonText: "Delete",
                context: context,
                );
            },
          ),




        ]
            : null,

        iconTheme: IconThemeData(color: ColorsManager.blue),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Event Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(typeImage[event.type].toString()),
              ),
              SizedBox(height: 16),
              Text(
                "${event.title}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.blue,
                ),
              ),
              CustomOutlinedButton(date: formattedDate, time: formattedTime),
              SizedBox(height: 16),
              CustomOutlinedButton(
                location: "${event.city} , ${event.country}",
                isLocation: true,
              ),
              SizedBox(height: 16),
              Container(
                height: height * 0.4,
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsManager.blue),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: eventLatLng,
                      zoom: 14,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),
              Text(
                "Description",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Text(
                "${event.description}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
