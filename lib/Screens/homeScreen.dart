import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:secured_chat_app/Screens/loginScreen.dart';
import 'package:secured_chat_app/Screens/registrationScreen.dart';
import 'package:secured_chat_app/constants.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: k_mainColor,
        body: Center(
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 100, horizontal: 40),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(60)),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Hero(
                            tag: 'yildiz',
                            child: Image.asset(
                              "images/YILDIZ.png",
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "HAVELSAN Chat",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: k_mainColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
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
                                      color: Colors.white, fontSize: 25),
                                ),
                                onPressed: () => Navigator.pushNamed(
                                    context, LogInScreen.id))),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                                child: Text(
                                  "SignIn",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                onPressed: () => Navigator.pushNamed(
                                    context, RegistrationScreen.id)))
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
