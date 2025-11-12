import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/resourse/DialogUtils.dart';
import 'package:evently_app/main.dart';
import 'package:evently_app/models/UserModel.dart';
import 'package:evently_app/screens/onboarding_start/widgets/custom_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/resourse/AppConstant.dart';
import '../../core/resourse/AssetsManager.dart';
import '../../core/resourse/ColorsManager.dart';
import '../../core/resourse/RouteManager.dart';
import '../../services/Firebase_storageManager.dart';
import '../CustomButton.dart';
import '../login/widgets/CustomTextField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController nameController;

  late TextEditingController repassController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    repassController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    repassController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  String selectedLanguage = "en";

  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsManager.blue),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "register".tr(),
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      AssetsManager.logo,
                      height: height * 0.22,
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomTextField(
                    hint: "name".tr(),
                    prefix: AssetsManager.person,
                    onChanged: (value) {},
                    controller: nameController,
                    fieldType: FieldType.name,
                    action: TextInputAction.next,
                  ),
                  SizedBox(height: 16),

                  CustomTextField(
                    hint: "email".tr(),
                    prefix: AssetsManager.email,
                    onChanged: (value) {},
                    controller: emailController,
                    fieldType: FieldType.email,
                    action: TextInputAction.next,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    hint: "pass".tr(),
                    prefix: AssetsManager.pass,
                    onChanged: (value) {},
                    controller: passwordController,
                    isPassword: true,
                    fieldType: FieldType.password,
                    action: TextInputAction.next,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    hint: "re_pass".tr(),
                    prefix: AssetsManager.pass,
                    onChanged: (value) {},
                    controller: repassController,
                    isPassword: true,
                    fieldType: FieldType.rePassword,
                    passwordController: passwordController,
                    action: TextInputAction.done,
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    title: "cre_acc",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        createAccount();
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "hav_acc".tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          Navigator.of(context).pushNamed(RouteManager.login);
                        },
                        child: Text(
                          "log".tr(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  CustomSwitch(
                    values: ["en", "ar"],
                    current: selectedLanguage,
                    icon1: AssetsManager.america,
                    icon2: AssetsManager.egypt,
                    onChange: (value) {
                      setState(() {
                        selectedLanguage = value;
                      });
                      if (selectedLanguage == "ar") {
                        context.setLocale(Locale("ar"));
                      } else {
                        context.setLocale(Locale("en"));
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

  createAccount() async {
    try {
      DialogUtils.LoadingDialog(context);
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      Navigator.of(context).pop();
      await FirebaseStorageManager.AddUser(
        UserModel(
          id: credential.user!.uid,
          name: nameController.text,
          email: emailController.text,
        ),
      );
      DialogUtils.toastMessage("Account Created Successfully");

    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == 'weak-password') {
        DialogUtils.DialogMessage(
          content:'The password provided is too weak.' ,
          message: 'Confirm Validation',
          context: context,
          positiveOnPressed: () {
            Navigator.of(context).pop();
          },
          positiveButtonText: "Ok",
        );
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.DialogMessage(
          message: 'Confirm Validation',
          content: 'The account already exists for that email.',
          context: context,
          positiveOnPressed: () {
            Navigator.of(context).pop();
          },
          positiveButtonText: "Ok",
        );
      }
    } catch (error) {
      DialogUtils.DialogMessage(
          message: 'Confirm Validation',
        content: error.toString(),
        context: context,
        positiveOnPressed: () {
          Navigator.of(context).pop();
        },
        positiveButtonText: "Ok",
      );
    }
  }
}
