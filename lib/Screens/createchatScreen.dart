import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secured_chat_app/Screens/chatScreen.dart';
import 'package:secured_chat_app/Widgets/inputWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

final _firestore = FirebaseFirestore.instance;

class CreateChat extends StatefulWidget {
  static const String id = "createchat_screen";
  const CreateChat({Key? key}) : super(key: key);

  @override
  _CreateChatState createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> {
  final TextEditingController newChatController = TextEditingController();
  bool isCollectionCreated = false;
  void createCollection() async {
    final a = await _firestore
        .collection(newChatController.text)
        .add({'text': "", 'sender': ""});
    setState(() {
      if (a != null) {
        isCollectionCreated = true;
      } else {
        isCollectionCreated = false;
      }
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => (ChatScreen(
                chatName: newChatController.text,
              ))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: k_mainColor,
        body: Center(
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(60)),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
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
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InputWidgets(
                        nameController: newChatController,
                        labelString: "Enter Group Chat Name",
                        hintString: "Enter Group Chat Name",
                      ),
                      Flexible(
                        child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                                child: Text(
                                  "Create",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                onPressed: () => !isCollectionCreated
                                    ? createCollection()
                                    : CircularProgressIndicator())),
                      )
                    ],
                  )),
                ],
              )),
        ),
      ),
    );
  }
}
