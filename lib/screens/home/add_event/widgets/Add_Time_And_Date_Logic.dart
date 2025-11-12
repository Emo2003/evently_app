import 'package:flutter/material.dart';

class DateAndTime{
  static chooseDate(  BuildContext context,DateTime selectedDate)async{
   return showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

  }
  static  chooseTime(  BuildContext context)async{
return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );


  }
}

