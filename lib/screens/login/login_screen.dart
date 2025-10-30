import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:evently_app/core/resourse/DialogUtils.dart';
import 'package:evently_app/core/resourse/RouteManager.dart';
import 'package:evently_app/screens/CustomButton.dart';
import 'package:evently_app/screens/login/widgets/CustomTextField.dart';
import 'package:evently_app/screens/onboarding_start/widgets/custom_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/UserProvider.dart';
import '../../main.dart';
import '../../models/UserModel.dart';
import '../../services/Firebase_storageManager.dart';
import '../home/home_screen.dart';
import '../../services/fire_base_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedLanguage="en";
  late TextEditingController emailController ;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    selectedLanguage=context.locale.languageCode;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0,
              vertical: 10),
          child: Form(
            key:_formKey ,
            child: Column(
              children: [
                Center(child: Image.asset(
                    AssetsManager.logo,
                    height: height*0.23)),
                SizedBox(height: 24,),
                CustomTextField(hint: "email".tr(),
                  prefix: AssetsManager.email,
                  onChanged: (value){},
                  controller: emailController,
                  action: TextInputAction.next,
                  fieldType: FieldType.email,
                ),
                SizedBox(height: 16,),
                CustomTextField(hint: "pass".tr(),
                  prefix: AssetsManager.pass,
                  onChanged: (value){},
                  controller:passwordController ,
                  isPassword: true,
                  action: TextInputAction.next,
                  fieldType: FieldType.password,
                ),
                SizedBox(height: 16,),
                TextButton(
                    onPressed: (){}
                    , child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("forget".tr()
                    ,style: Theme.of(context).textTheme.headlineSmall
                    ,),
                )),
                SizedBox(height: 16,),
                CustomButton(
                    title: "log",
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        signin();
                      }
                    }),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("don_hav_acc".tr(),
                      style: Theme.of(context).textTheme.titleMedium,),
                    TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: (){
                          Navigator.of(context).pushNamed(RouteManager.register);
                        }
                        , child: Text("cre_acc".tr(),
                      style: Theme.of(context).textTheme.headlineSmall,))
                  ],
                ),
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10.0),
                      child: Divider(height: 0
                        ,endIndent: 10,
                        thickness: 1,
                        color: ColorsManager.blue,),
                    )),
                    Text(" Or   ",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: ColorsManager.blue
                      ),),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(height: 0
                        ,endIndent:10 ,
                        thickness: 1,
                        color: ColorsManager.blue,),
                    )),
                  ],
                ),
                SizedBox(height: 24,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                      ),
                      minimumSize: Size(double.infinity, 60),
                    ),
                    onPressed: () async {
                      try {
                        final userCredential = await FirebaseServices().signInWithGoogle();
                        if (userCredential == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login cancelled or failed")),
                          );
                          return;
                        }
                        final uid = userCredential.user!.uid;
                        var existingUser = await FirebaseStorageManager.GetUsers(uid);
                        if (existingUser == null) {
                          final newUser = UserModel(
                            id: uid,
                            name: userCredential.user!.displayName,
                            email: userCredential.user!.email,
                          );
                          await FirebaseStorageManager.AddUser(newUser);
                          existingUser = newUser;
                        }

                        Navigator.pushReplacementNamed(context, RouteManager.home);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login failed: $e")),
                        );
                      }
                    },



                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsManager.google, height: height*0.03,),
                        SizedBox(width: 10,),
                        Text("log_gog".tr(),
                            style:Theme.of(context).textTheme.headlineLarge),
                      ],
                    )
                ),
               SizedBox(height: 30,),
                CustomSwitch(
                  values: ["en","ar"],
                  current: selectedLanguage,
                  icon1: AssetsManager.america,
                  icon2: AssetsManager.egypt,
                  onChange: (value){
                    setState(() {
                      selectedLanguage=value;
                    });
                    if(selectedLanguage=="ar"){
                      context.setLocale(Locale("ar"));
                    }
                    else{
                      context.setLocale(Locale("en"));
                    }
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  signin() async {

    try {
      DialogUtils.LoadingDialog(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pop(context);

      DialogUtils.DialogMessage(
          context: context,
          message: "Login Successfully !",
          positiveOnPressed: (){
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true)
                .pushReplacementNamed(RouteManager.home);
          },
          positiveButtonText: "Ok");
      print(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        DialogUtils.DialogMessage(
            context: context,
            message: ' No user found for that email.',
            positiveOnPressed: (){
              Navigator.pop(context);
            },
            positiveButtonText: "Ok");

      } else if (e.code == 'wrong-password'
          || e.code == 'invalid-credential') {
        DialogUtils.DialogMessage(
            context: context,
            message: 'Wrong email or password.',
            positiveOnPressed: (){
              Navigator.pop(context);
            },
            positiveButtonText: "Ok");
      } else {
        DialogUtils.DialogMessage(
            context: context,
            message: ' Firebase error: ${e.code} - ${e.message}',
            positiveOnPressed: (){
              Navigator.pop(context);
            },
            positiveButtonText: "Ok");
      }
    } catch (e) {
      Navigator.pop(context);
      DialogUtils.DialogMessage(
          context: context,
          message: 'Unexpected error: $e',
          positiveOnPressed: (){
            Navigator.pop(context);
          },
          positiveButtonText: "Ok");
    }
  }
}