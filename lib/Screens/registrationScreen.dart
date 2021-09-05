import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secured_chat_app/Screens/chatScreen.dart';
import 'package:secured_chat_app/Screens/createChatScreen.dart';
import 'package:secured_chat_app/Screens/joinchatScreen.dart';
import 'package:secured_chat_app/Widgets/inputWidgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:secured_chat_app/constants.dart';
import 'package:email_auth/email_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool isLoading = false;
  bool isOtpScreen = false;
  bool isVerified = false;

  bool cautionText = false;
  int caution_number = 0;
  final _auth = FirebaseAuth.instance;
  EmailAuth emailAuth = EmailAuth(sessionName: "HAVELSAN Chat");

  var verificationCode;

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void sendOTP() async {
    setState(() {
      isLoading = true;
      cautionText = false;
    });

    var res = await emailAuth.sendOtp(recipientMail: emailController.text);

    if (res) {
      print("OTP sent");
      setState(() {
        isOtpScreen = true;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        cautionText = true;
        caution_number = 1;
        //Navigator.pop(context);
      });

      print("We could not sent");
    }
  }

  void verifyOTP() async {
    setState(() {
      isLoading = true;
      cautionText = false;
    });
    var res = await emailAuth.validateOtp(
        recipientMail: emailController.text, userOtp: otpController.text);

    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: "emptypassword");

      if (res) {
        print("oye");
        setState(() {
          isLoading = false;
          isVerified = true;
          cautionText = false;

        });
        print("OTP verified");
      } else {
        print("OTP not verified");
        setState(() {
          isLoading = false;
          isVerified = false;
          cautionText = true;
          caution_number = 2;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
        isVerified = false;
        cautionText = true;
        caution_number = 1;
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
                    child: !isVerified
                        ? Column(
                            children: [
                              SizedBox(
                                height: 40,
                                child: cautionText
                                    ? Container(
                                        padding: EdgeInsets.only(top: 20),
                                        child: (caution_number == 1)
                                            ? Text(
                                                "This e-mail address already in use.",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )
                                            : Text(
                                                "Wrong verificitaion code.",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                      )
                                    : null,
                              ),
                              isOtpScreen
                                  ? InputWidgets(
                                      nameController: otpController,
                                      labelString: "Enter verification number",
                                      hintString:
                                          "Enter the verification number you have",
                                    )
                                  : InputWidgets(
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
                                          child: isOtpScreen
                                              ? Text(
                                                  "Verify",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                )
                                              : Text(
                                                  "SignIn",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                ),
                                          onPressed: () =>
                                              (isOtpScreen == false)
                                                  ? sendOTP()
                                                  : verifyOTP()),
                                    )
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                  height: 40,
                                  child: Container(
                                    child: Text(
                                      "Your verification code is correct.",
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
