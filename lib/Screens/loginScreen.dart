import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secured_chat_app/Screens/chatScreen.dart';
import 'package:secured_chat_app/Screens/joinchatScreen.dart';
import 'package:secured_chat_app/Widgets/inputWidgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:secured_chat_app/constants.dart';
import 'package:email_auth/email_auth.dart';

import 'createchatScreen.dart';

class LogInScreen extends StatefulWidget {
  static const String id = "login_screen";
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool isLoading = false;
  bool isOtpScreen = false;
  bool isVerified = false;
  bool cautionText = false;
  bool isLoggedIn = false;

  final _auth = FirebaseAuth.instance;
  EmailAuth emailAuth = EmailAuth(sessionName: "HAVELSAN Chat");

  var verificationCode;
  bool isLogedIn = false;

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void logingIn() async {
    setState(() {
      isLoading = true;
      cautionText = false;
    });
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: "emptypassword");

      if (user != null) {
        //Navigator.pushNamed(context, JoinChat.id);
        setState(() {
          isLoading = false;
          cautionText = false;
          isLogedIn = true;
        });
      }
    } catch (e) {
      setState(() {
        cautionText = true;
        isLoading = false;
        isLogedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: k_mainColor),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Hero(
                    tag: 'yildiz',
                    child: Image.asset(
                      "images/YILDIZ.png",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60)),
                  child: SingleChildScrollView(
                    child: !isLogedIn
                        ? Column(
                            children: [
                              SizedBox(
                                height: 40,
                                child: cautionText
                                    ? Container(
                                        child: Text(
                                          emailController.text + " not found",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        alignment: Alignment.bottomCenter,
                                      )
                                    : null,
                              ),
                              InputWidgets(
                                nameController: emailController,
                                labelString: "Enter your e-mail address",
                                hintString: "Enter valid e-mail address",
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              isLoading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.red))
                                  : Container(
                                      height: 50,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextButton(
                                          child: Text(
                                            "LogIn",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                          onPressed: () => logingIn()
                                          //isOtpScreen ? otpSignIn() : phoneAuth();
                                          //Navigator.pushNamed(context, HomeScreen.id),
                                          ),
                                    )
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                  height: 40,
                                  child: Container(
                                    child: Text(
                                      "${_auth.currentUser!.email.toString()} is logged in.",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    alignment: Alignment.bottomCenter,
                                  )),
                              SizedBox(
                                height: 100,
                              ),
                              isLoading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.red))
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            height: 50,
                                            width: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: TextButton(
                                                child: Text(
                                                  "Create Chat",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pushNamed(context,
                                                        CreateChat.id))),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Container(
                                            height: 50,
                                            width: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: TextButton(
                                                child: Text(
                                                  "Join Chat",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pushNamed(
                                                        context, JoinChat.id)))
                                      ],
                                    )
                            ],
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
