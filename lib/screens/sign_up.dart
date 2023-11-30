import 'package:chat_app/cubits/logincubit/logincubit.dart';
import 'package:chat_app/cubits/registercubit/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/model/textform_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/model/snackbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class signup extends StatefulWidget {
  signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  String? myemail;
  bool isloading = false;

  String? mypassword;

  String? username;

  GlobalKey<FormState> formkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is registerloading) {
          isloading = true;
        } else if (state is registersucess) {
          Navigator.of(context).pushNamed("login");
          isloading = false;
        } else if (state is registerfaliure) {
          isloading = false;
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isloading,
          child: Scaffold(
              backgroundColor: Color.fromARGB(255, 4, 50, 130),
              body: SingleChildScrollView(
                  child: Column(children: [
                SizedBox(
                  height: 120,
                ),
                Container(
                    height: 200,
                    width: double.infinity,
                    child: Column(children: [
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset("images/chatapp.png")),
                      Text(
                        "School Chat",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ])),
                Form(
                    key: formkey,
                    child: Column(
                      children: [
                        customtextfield(
                          obscuretext: false,
                          onChanged: (data) {
                            myemail = data;
                          },
                          hinttext: "Email",
                          prefixicon: Icon(Icons.email),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        customtextfield(
                          obscuretext: true,
                          onChanged: (data) {
                            mypassword = data;
                          },
                          hinttext: "Password",
                          prefixicon: Icon(Icons.lock),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                            height: 40,
                            width: 400,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .signup(
                                          myemail: myemail!,
                                          mypassword: mypassword!);
                                }
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have An Acoount ? ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed("login");
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ))
                          ],
                        )
                      ],
                    ))
              ]))),
        );
      },
    );
  }
}
