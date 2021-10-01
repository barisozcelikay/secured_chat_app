import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secured_chat_app/Screens/chatScreen.dart';
import 'package:secured_chat_app/Widgets/inputWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

class CreateChat extends StatefulWidget {
  static const String id = "createchat_screen";
  const CreateChat({Key? key}) : super(key: key);

  @override
  _CreateChatState createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> {
  final TextEditingController newChatController = TextEditingController();
  bool isCollectionCreated = false;
  bool cautionText = false;
  bool roomValid = false;
  bool isLoading = false;

  void createCollection() {
    setState(() {
      isLoading = true;
      isCollectionCreated = false;
    });
    var snapshot =
        FirebaseFirestore.instance.collection('/${newChatController.text}');

    snapshot.get().then((querySnapshot) {
      if (querySnapshot.size == 0) {
        setState(() {
          roomValid = true;
          cautionText = false;
          isCollectionCreated = true;
          isLoading = false;
        });
        print("oda acildi");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => (ChatScreen(
                  chatName: newChatController.text,
                ))));
      } else {
        print("oda acilmadi");
        setState(() {
          roomValid = false;
          cautionText = true;
          isCollectionCreated = false;
          isLoading = false;
        });
      }
    });

/*
    setState(() {
      if (a != null) {
        isCollectionCreated = true;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => (ChatScreen(
                  chatName: newChatController.text,
                ))));
      } else {
        isCollectionCreated = false;
      }
    });
    */
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
                              "images/peace-finger-sign-png.png",
                              color: Colors.red,
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
                      SizedBox(
                        child: cautionText
                            ? Text(
                                'You can not create room with named ${newChatController.text}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            : !isLoading
                                ? Text("")
                                : CircularProgressIndicator(),
                      ),
                      InputWidgets(
                        nameController: newChatController,
                        labelString: "Create Group Chat Name",
                        hintString: "Create new Group Chat Name",
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
