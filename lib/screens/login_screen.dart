import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/cubits/chatcubit/chat_cubit.dart';
import 'package:chat_app/cubits/logincubit/logincubit.dart';
import 'package:chat_app/model/snackbar.dart';
import 'package:chat_app/model/textform_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  GlobalKey<FormState> formkey = new GlobalKey();

  String? myemail;

  String? mypassword;
  bool isloading = false;

  Widget build(BuildContext context) {
    return BlocConsumer<Logincubit, loginstate>(
      listener: (context, state) {
        if (state is loginloading) {
          isloading = true;
        } else if (state is loginSucess) {
          BlocProvider.of<ChatCubit>(context).getMesseges();
          Navigator.of(context)
              .pushReplacementNamed('chat_page', arguments: myemail);
        } else if (state is loginFailure) {
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
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      children: [
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
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Form(
                          key: formkey,
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: customtextfield(
                                    obscuretext: false,
                                    onChanged: (data) {
                                      myemail = data;
                                    },
                                    hinttext: "Email",
                                    prefixicon: Icon(Icons.email),
                                  )),
                              SizedBox(
                                height: 16,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: customtextfield(
                                    obscuretext: true,
                                    onChanged: (data) {
                                      mypassword = data;
                                    },
                                    hinttext: "Password",
                                    prefixicon: Icon(Icons.lock),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  height: 40,
                                  width: 400,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          BlocProvider.of<Logincubit>(context)
                                              .login(
                                                  myemail: myemail!,
                                                  mypassword: mypassword!);
                                        }
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ))),
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have An Acoount ? ",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('signup');
                              },
                              child: Text(
                                "Sign Up",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 20),
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
