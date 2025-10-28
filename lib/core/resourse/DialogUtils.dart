import 'package:flutter/material.dart';

class DialogUtils{
  static LoadingDialog( BuildContext context){
    showDialog(context:context ,
        barrierDismissible: false,
        builder: (context)=>AlertDialog(
      title: Column(
        children: [
          Container(
            child: CircularProgressIndicator(color: Colors.blue,
            ),
          ),

        ],
      ),
    ));
  }
  static DialogMessage(
  { required String message,
     required BuildContext context,
      required  void Function() positiveOnPressed,
      required String positiveButtonText,
      Function()? negativeOnPressed,
      String? negativeButtonText,}){
    showDialog(context: context,
        barrierDismissible: false,
        builder:
        (context)=>AlertDialog(
       title:Text(message, style:
       Theme.of(context).textTheme.titleMedium,) ,
          actions:[
            TextButton(onPressed: (){
              positiveOnPressed();
            }, child: Text(positiveButtonText, style:
            Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.blue
            ))),
            if(negativeButtonText != null)
            TextButton(onPressed: (){
              negativeOnPressed?.call();
            }, child: Text(negativeButtonText, style:
            Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.blue
            ))),
          ]
    ) );
  }


}