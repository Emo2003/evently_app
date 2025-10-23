import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/resourse/AssetsManager.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:evently_app/core/resourse/RouteManager.dart';
import 'package:evently_app/screens/CustomButton.dart';
import 'package:evently_app/screens/login/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../home/home_screen.dart';
import '../../services/fire_base_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late TextEditingController emailController ;
  late TextEditingController passwordController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                        final user = await FirebaseServices().signInWithGoogle();

                        if (user != null) {
                          Navigator.pushReplacement(
                            context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login cancelled or failed")),
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
                  )

                ],
            ),
          ),
        ),
      ),
    );
  }
}
