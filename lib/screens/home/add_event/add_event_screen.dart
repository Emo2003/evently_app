import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/providers/CreateEventProvider.dart';
import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/core/resourse/DialogUtils.dart';
import 'package:evently_app/screens/home/TabBar_Items/widgets/tab_items.dart';
import 'package:evently_app/screens/home/add_event/widgets/custom_outlined_button.dart';
import 'package:evently_app/screens/home/add_event/widgets/row_choosen.dart';
import 'package:evently_app/screens/login/widgets/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resourse/AppConstant.dart';
import '../../../core/resourse/ColorsManager.dart';
import '../../../models/EventModel.dart';
import '../../../services/Firebase_storageManager.dart';
import '../../CustomButton.dart';
import 'widgets/Add_Time_And_Date_Logic.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    // TODO: implement initState
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
  Widget build(BuildContext context) {
    CreateEventProvider provider = Provider.of<CreateEventProvider>(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:  Text(
          'Create Event',
          style: Theme.of(context).textTheme.titleLarge
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorsManager.blue),
      ),
      body: DefaultTabController(
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
                    fieldType: FieldType.title,
                    hint: "Enter Title For Event",
                    action: TextInputAction.next,
                    onChanged: (value) {},
                    controller: titleController,
                    prefix: "assets/images/Note_Edit.svg",
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  CustomTextField(
                    fieldType: FieldType.description,
                    maxLines: 5,
                    hint: "Event Description",
                    action: TextInputAction.next,
                    onChanged: (value) {},
                    controller: descriptionController,
                  ),
                  SizedBox(height: 10),
                  EventDateAndTime(
                    onPressed: () async {
                      selectedDate = await DateAndTime.chooseDate(
                        context,
                        selectedDate ?? DateTime.now(),
                      );
                      if (selectedDate != null) {
                        setState(() {});
                      }
                    },
                    title: "Event Date",
                    image: AssetsManager.calendar,
                    choose: selectedDate == null
                        ? "Select Date"
                        : "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}",
                  ),
                  EventDateAndTime(
                    onPressed: () async {
                      selectedTime = await DateAndTime.chooseTime(context);
                      if (selectedTime != null) {
                        setState(() {});
                      }
                    },
                    title: "Event Time",
                    image: AssetsManager.clock,
                    choose: selectedTime == null
                        ? "Select Time"
                        : "${selectedTime?.hourOfPeriod}:${selectedTime?.minute} ${selectedTime?.period.name}",
                  ),
                  SizedBox(height: 8),
                  Text("Location", style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 8),
                  CustomOutlinedButton(provider: provider,isLocation: true,),
                  SizedBox(height: 16),
                  CustomButton(title: 'Add Event',
                      onPressed: () async{
                    if (formKey.currentState!.validate()) {
                      if (selectedDate != null && selectedTime != null) {
                       Event event =Event(
                         city: provider.city ,
                         country: provider.country,
                         title: titleController.text,
                         description: descriptionController.text,
                          userId: FirebaseAuth.instance.currentUser!.uid ,
                          latitude: provider.eventLocation?.latitude ?? 0,
                         longitude: provider.eventLocation?.longitude ?? 0,
                         type: types[selectedIndex],
                         dateTime: Timestamp.fromDate(DateTime(
                           selectedDate!.year,
                           selectedDate!.month,
                           selectedDate!.day,
                           selectedTime!.hourOfPeriod,
                           selectedTime!.minute,
                         )),
                       );
                       DialogUtils.LoadingDialog(context);
                      await FirebaseStorageManager.addEvent(event);
                       Navigator.pop(context);
                      DialogUtils.toastMessage("Event Added Successfully");
                      }
                      else{
                       DialogUtils.toastMessage("Choose Date And Time");
                      }
                    }}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
