import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/screens/CustomButton.dart';
import 'package:evently_app/screens/login/widgets/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/resourse/AppConstant.dart';
import '../../../core/resourse/ColorsManager.dart';
import '../../../main.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  late TextEditingController emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  didChangeDependencies() {
    super.didChangeDependencies();
    String email = ModalRoute.of(context)?.settings.arguments as String;
    emailController = TextEditingController(text: email);
  }

  dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsManager.blue, size: 30),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Forget Password',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(AssetsManager.reset_pass),
              SizedBox(height: 24),
              CustomTextField(
                hint: "email".tr(),
                prefix: AssetsManager.email,
                onChanged: (value) {},
                controller: emailController,
                action: TextInputAction.next,
                fieldType: FieldType.email,
              ),
              SizedBox(height: 24),
              CustomButton(title: "Reset Password", onPressed: ResetPassword),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> ResetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
