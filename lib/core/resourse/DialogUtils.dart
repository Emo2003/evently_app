import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    required String content,
     required BuildContext context,
      required  void Function() positiveOnPressed,
      required String positiveButtonText,
      Function()? negativeOnPressed,
      String? negativeButtonText,}){
    showDialog(context: context,
        barrierDismissible: false,
        builder:
        (context)=>AlertDialog(
          title: Text(message, style: Theme.of(context).textTheme.headlineLarge,),
       content:Text(content, style:
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

  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorsManager.blue,
        textColor: ColorsManager.backgroundLight,
        fontSize: 20.0
    );
  }


}