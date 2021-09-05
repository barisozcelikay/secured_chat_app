import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secured_chat_app/Screens/chatScreen.dart';
import 'package:secured_chat_app/Widgets/inputWidgets.dart';
import '../constants.dart';

final _firestore = FirebaseFirestore.instance;

class JoinChat extends StatefulWidget {
  static const String id = "joinchat_screen";
  final chatName;
  const JoinChat({Key? key, this.chatName}) : super(key: key);

  @override
  _JoinChatState createState() => _JoinChatState();
}

class _JoinChatState extends State<JoinChat> {
  void checkRoomValid() async {
    final snapshot = await _firestore.collection(chatNameController.text);
    print(snapshot.id +
        " " +
        snapshot.path +
        " " +
        snapshot.parent.toString() +
        " " +
        snapshot.firestore.toString());
    if (snapshot != null && snapshot.parent == null) {
      setState(() {
        roomValid = true;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => (ChatScreen(
                chatName: chatNameController.text,
              ))));
      //doesnt exist
    } else {
      setState(() {
        roomValid = false;
      });
    }
  }

  bool roomValid = false;
  final TextEditingController chatNameController = TextEditingController();
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
                        nameController: chatNameController,
                        labelString: "Enter Group Chat Name",
                        hintString: "Enter Group Chat That You Join",
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
                              "Join",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            onPressed: () => checkRoomValid()),
                      ))
                    ],
                  ))
                ],
              )),
        ),
      ),
    );
  }
}
