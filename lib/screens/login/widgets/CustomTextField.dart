import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../main.dart';

class CustomTextField extends StatefulWidget {
  final FieldType fieldType;
  String hint;
  String prefix;
  String suffix;
  bool isPassword;
  Function(String) onChanged;
  TextEditingController controller;
  TextEditingController? passwordController;
  TextInputAction action;

   CustomTextField({super.key,
     required this.hint,
     this.passwordController,
     required this.fieldType,
     required this.action,
     required this.onChanged,
     required this.controller,
     this.isPassword=false,
   required this.prefix,
   this.suffix=""});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  final RegExp passwordRegex =
  RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
  late bool isActive= widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.action,
        validator: (value) {
          if (value == null || value.isEmpty) {
            switch (widget.fieldType) {
              case FieldType.name:
                return "Invalid Name";
              case FieldType.email:
                return "Invalid Email";
              case FieldType.password:
                return "Invalid Password";
              case FieldType.rePassword:
                return "Please re-enter password";
            }
          }

          if (widget.fieldType == FieldType.password) {
            if (!passwordRegex.hasMatch(value)) {
              return "Password should contain at least 1 uppercase, 1 lowercase, 1 number, and 1 special character";
            }
          }

          if (widget.fieldType == FieldType.rePassword) {
            if (value != widget.passwordController?.text) {
              return "Passwords do not match";
            }
          }


          if (widget.fieldType == FieldType.email) {
            if (!emailRegex.hasMatch(value)) {
              return "Invalid Email";
            }
          }

          return null;
        },
       style: Theme.of(context).textTheme.titleSmall,
      obscureText: isActive,
      controller: widget.controller,
      onChanged: widget.onChanged ,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.titleSmall,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSecondary,
                BlendMode.srcIn),
              widget.prefix,
          width: 25,
            height: 25,),
        ),
       suffixIcon: widget.isPassword
           ?IconButton(
         color: Theme.of(context).colorScheme.onSecondary,
           onPressed: (){
             setState(() {
               isActive=!isActive;
             });
           },
         icon: Icon(
           color: Theme.of(context).colorScheme.onSecondary,
           !isActive?
           Icons.visibility:
         Icons.visibility_off),
       )
           :null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary)
        ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary)
        ),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary)
        ),
        errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary)
        ),
      ),
    );
  }
}
