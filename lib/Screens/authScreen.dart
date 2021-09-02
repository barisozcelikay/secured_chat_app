import 'package:flutter/material.dart';
import 'package:secured_chat_app/Widgets/inputWidgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  bool isOtpScreen = false;
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.blue[900]),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                  height: 150,
                  child: Column(
                    children: [
                      Expanded(
                        child: Hero(
                          tag: 'yildiz',
                          child: Image.asset(
                            "images/YILDIZ.png",
                          ),
                        ),
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('Havelsan Chat',
                              textStyle: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              speed: const Duration(milliseconds: 200)),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 60,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        isOtpScreen
                            ? InputWidgets(
                                phoneController: phoneController,
                                labelString: "Enter otp number",
                                hintString: "Enter the otp number you have",
                              )
                            : InputWidgets(
                                phoneController: phoneController,
                                labelString: "Enter phone number",
                                hintString: "Enter valid phone number",
                              ),
                        SizedBox(
                          height: 30,
                        ),
                        isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red))
                            : Container(
                                height: 50,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                  onPressed: () {},
                                ),
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
