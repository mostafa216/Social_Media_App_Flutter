import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/View/Pages/register_scr.dart';

import 'package:social_app/ViewModel/Database/local/sharedPreferns.dart';

import '../../ViewModel/Cupits/SocialCupit/cupit.dart';
import '../../ViewModel/Cupits/SocialCupit/states.dart';
import 'Home_Scr.dart';

class LOGIN_SCR extends StatelessWidget {
  LOGIN_SCR({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return BlocConsumer<SocialCupit, SocialAppStates>(
        listener: (context, state) {
          if (state is LOGINSuccessStates) {
            CashHelper.SaveData(key: 'uId', value: state.uId);
            Fluttertoast.showToast(
                msg: "Success",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return MyHomePage();
            }));
          } else if (state is LOGINErrorStates) {
            Fluttertoast.showToast(
                msg: "Error",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) => Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "login now to browse our hot offers",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter email";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email Address",
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: passController,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "password is required";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              onFieldSubmitted: (vale) {
                                if (formKey.currentState!.validate()) {
                                  SocialCupit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passController.text);
                                }
                              },
                              // obscureText: loginCubit.get(context).isPassowrdShown,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password",
                                prefixIcon: Icon(Icons.lock),
                                // suffixIcon: IconButton(
                                //     icon: Icon(loginCubit.get(context).loginSuffix),
                                //     onPressed: () {
                                //       loginCubit.get(context).changeShonPass();
                                //     })
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialCupit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passController.text);
                                  }
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                color: Colors.blue,
                              ),
                            ),
                            Row(
                              children: [
                                Text("Don't have an account? "),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  REGESTER_SCR()));
                                    },
                                    child: Text("Sign Up")),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
