import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/resourse/AppConstant.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:evently_app/core/resourse/RouteManager.dart';
import 'package:evently_app/screens/home/add_event/widgets/custom_outlined_button.dart';
import 'package:evently_app/screens/home/add_event/widgets/row_choosen.dart';
import 'package:evently_app/services/Firebase_storageManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/CreateEventProvider.dart';
import '../../../core/resourse/AssetsManager.dart';
import '../../../core/resourse/DialogUtils.dart';
import '../../../models/EventModel.dart';
import '../../CustomButton.dart';
import '../../login/widgets/CustomTextField.dart';
import '../TabBar_Items/widgets/tab_items.dart';
import '../add_event/widgets/Add_Time_And_Date_Logic.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late int selectedIndex;
  String formattedDate = "";
  String formattedTime = "";
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late Event event;
  bool _isInit = false;

  @override
  initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      event = ModalRoute.of(context)!.settings.arguments as Event;

      selectedIndex = types.indexOf(event.type!);
      if (selectedIndex == -1) selectedIndex = 0;

      if (event.dateTime != null) {
        final date = event.dateTime!.toDate();
        formattedDate = "${date.day}/${date.month}/${date.year}";
        formattedTime = DateFormat.jm().format(date);
      }
      titleController.text = event.title ?? "";
      descriptionController.text = event.description ?? "";
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    CreateEventProvider provider = Provider.of<CreateEventProvider>(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsManager.blue),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Edit Event',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        initialIndex: selectedIndex,
        length: 3,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.24,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: Image.asset(
                            AssetsManager.book_club,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: Image.asset(
                            AssetsManager.sport,
                            fit: BoxFit.fill,
                            height: 100,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: Image.asset(
                            AssetsManager.birthday,
                            fit: BoxFit.fill,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  TabBar(
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.only(right: 20),
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                    tabs: [
                      TabItems(
                        CreateEvent: true,
                        svgPicture: false,
                        icon: Icons.menu_book_outlined,
                        colorIcon: selectedIndex == 0
                            ? ColorsManager.backgroundLight
                            : ColorsManager.blue,
                        title: "BookClub",
                        colorText: selectedIndex == 0
                            ? ColorsManager.backgroundLight
                            : ColorsManager.blue,
                        color: ColorFilter.mode(
                          selectedIndex == 0
                              ? ColorsManager.backgroundLight
                              : ColorsManager.blue,
                          BlendMode.srcIn,
                        ),
                        colorContainer: selectedIndex == 0
                            ? ColorsManager.blue
                            : Colors.transparent,
                      ),
                      TabItems(
                        CreateEvent: true,
                        image: "assets/images/bike.svg",
                        title: "Sport",
                        colorText: selectedIndex == 1
                            ? ColorsManager.backgroundLight
                            : ColorsManager.blue,
                        color: ColorFilter.mode(
                          selectedIndex == 1
                              ? ColorsManager.backgroundLight
                              : ColorsManager.blue,
                          BlendMode.srcIn,
                        ),
                        colorContainer: selectedIndex == 1
                            ? ColorsManager.blue
                            : Colors.transparent,
                      ),
                      TabItems(
                        CreateEvent: true,
                        image: "assets/images/cake.svg",
                        title: "BirthDay",
                        colorText: selectedIndex == 2
                            ? ColorsManager.backgroundLight
                            : ColorsManager.blue,
                        color: ColorFilter.mode(
                          selectedIndex == 2
                              ? ColorsManager.backgroundLight
                              : ColorsManager.blue,
                          BlendMode.srcIn,
                        ),
                        colorContainer: selectedIndex == 2
                            ? ColorsManager.blue
                            : Colors.transparent,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text("Title", style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: titleController,
                    fieldType: FieldType.title,
                    hint: "Enter Title of Event",
                    action: TextInputAction.next,
                    onChanged: (value) {},
                    prefix: "assets/images/Note_Edit.svg",
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  CustomTextField(
                    controller: descriptionController,
                    fieldType: FieldType.description,
                    maxLines: 5,
                    hint: "Enter Description of Event ",
                    action: TextInputAction.next,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 10),
                  EventDateAndTime(
                    onPressed: () async {
                      selectedDate = await DateAndTime.chooseDate(
                        context,
                        selectedDate ?? event.dateTime?.toDate() ?? DateTime.now(),
                      );
                      if (selectedDate != null) {
                        formattedDate = "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
                        setState(() {});
                      }
                    },
                    title: "Event Date",
                    image: AssetsManager.calendar,
                    choose: formattedDate,
                  ),
                  EventDateAndTime(
                    onPressed: () async {
                      selectedTime = await DateAndTime.chooseTime(context);
                      if (selectedTime != null) {
                        formattedTime = selectedTime!.format(context);
                        setState(() {});
                      }
                    },
                    title: "Event Time",
                    image: AssetsManager.clock,
                    choose: formattedTime,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Location",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  CustomOutlinedButton(
                    provider: provider,
                    isLocation: true,
                    location: "${event.city} , ${event.country}",
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    title: 'Update Event',
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        DialogUtils.toastMessage("Please fill all fields");
                        return;
                      }

                      DateTime finalDateTime = DateTime(
                        (selectedDate ?? event.dateTime!.toDate()).year,
                        (selectedDate ?? event.dateTime!.toDate()).month,
                        (selectedDate ?? event.dateTime!.toDate()).day,
                        (selectedTime?.hour ?? event.dateTime!.toDate().hour),
                        (selectedTime?.minute ?? event.dateTime!.toDate().minute),
                      );

                      Event updatedEvent = Event(
                        id: event.id,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        title: titleController.text,
                        description: descriptionController.text,
                        dateTime: Timestamp.fromDate(finalDateTime),
                        type: types[selectedIndex],
                        city: provider.city ?? event.city,
                        country: provider.country ?? event.country,
                        latitude: provider.eventLocation?.latitude ?? event.latitude,
                        longitude: provider.eventLocation?.longitude ?? event.longitude,
                      );

                      final parentContext = context;
                      DialogUtils.LoadingDialog(context);

                      try {
                        await FirebaseStorageManager.updateEvent(updatedEvent);
                        Navigator.pop(context);
                        Navigator.popAndPushNamed(parentContext,RouteManager.eventDetails, arguments: updatedEvent);
                        DialogUtils.toastMessage("Event Updated Successfully ✅");
                      } catch (e) {
                        Navigator.pop(context);
                        DialogUtils.toastMessage("Failed to update event: $e");
                      }
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
