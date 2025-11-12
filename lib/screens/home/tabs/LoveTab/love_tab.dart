import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:evently_app/screens/login/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../../models/EventModel.dart';
import '../../../../services/Firebase_storageManager.dart';
import '../../TabBar_Items/widgets/tab_screen.dart';

class LoveTab extends StatefulWidget {
  const LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Search for Event",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: ColorsManager.blue,
                ),
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: ColorsManager.blue,
                  size: 30,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: ColorsManager.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: ColorsManager.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: ColorsManager.blue),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: ColorsManager.blue),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: ColorsManager.blue),
                ),
              ),
              onChanged: (value) {},
              textInputAction: TextInputAction.search,
            ),
          ),
      Expanded(
        child: FutureBuilder(
            future: FirebaseStorageManager.getAllEvent(),
            builder: (context, snapshot) {
              if(snapshot.connectionState== ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.hasError){
                return Center(child: Text(snapshot.error.toString()),);
              }
              List<Event> event = snapshot.data!;
              return   ListView.separated(
                  itemBuilder:(_,index)=>TabScreen(event: event[index],) ,
                  separatorBuilder: (_,_)=> SizedBox(height: 20,),
                  itemCount:event.length );

            }
        ),
      )
        ],
      ),
    );
  }
}
