import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/resourse/AppConstant.dart';
import '../../../main.dart';

class CustomTextField extends StatefulWidget {
  final FieldType? fieldType;
  final String hint;
  final int? maxLines;
 final String? prefix;
  final String suffix;
 final bool isPassword;
 final Function(String) onChanged;
 final TextEditingController controller;
 final TextEditingController? passwordController;
 final TextInputAction action;

 const  CustomTextField({super.key,
     required this.hint,
     this.maxLines=1,
     this.passwordController,
      this.fieldType,
     required this.action,
     required this.onChanged,
       required this.controller,
     this.isPassword=false,
     this.prefix,
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
      maxLines: widget.maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget.action,
        validator: (value) {
          if (value == null || value.isEmpty) {
            switch (widget.fieldType!) {
              case FieldType.name:
                return "Invalid Name";
              case FieldType.email:
                return "Invalid Email";
              case FieldType.password:
                return "Invalid Password";
              case FieldType.rePassword:
                return "Please re-enter password";
              case FieldType.title:
               return "Please Enter Title";
              case FieldType.description:
              return "Enter Description";
              case FieldType.search:
               return "Enter any Name of Event ";
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
        prefixIcon: widget.prefix == null
            ? null
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            widget.prefix!,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onSecondary,
              BlendMode.srcIn,
            ),
          ),
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
