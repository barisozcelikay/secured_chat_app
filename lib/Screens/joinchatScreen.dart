import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secured_chat_app/Screens/chatScreen.dart';
import 'package:secured_chat_app/Widgets/customalert.dart';
import 'package:secured_chat_app/Widgets/customsnackbar.dart';
import 'package:secured_chat_app/Widgets/inputWidgets.dart';
import '../constants.dart';

class JoinChat extends StatefulWidget {
  static const String id = "joinchat_screen";
  final chatName;
  const JoinChat({Key? key, this.chatName}) : super(key: key);

  @override
  _JoinChatState createState() => _JoinChatState();
}

class _JoinChatState extends State<JoinChat> {
  bool cautionText = false;
  bool roomValid = false;
  bool isLoading = false;

  void checkRoomValid() async {
    setState(() {
      isLoading = true;
    });
    var snapshot =
        FirebaseFirestore.instance.collection('/${chatNameController.text}');

    snapshot.get().then((querySnapshot) {
      print('Size of documents in collection: ${querySnapshot.size}');
      if (querySnapshot.size > 0) {
        setState(() {
          roomValid = true;
          cautionText = false;
          isLoading = false;
        });
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => (ChatScreen(
                  chatName: chatNameController.text,
                ))));
        //doesnt exist
      } else {
        setState(() {
          roomValid = false;
          cautionText = true;
          isLoading = false;
          /* CustomSnackBar sentSnack = CustomSnackBar(
              message: 'Hata.',
              type: AlertType.Error,
              key: Key('ErrorSnack-1'),
              context: context);


          CustomAlert cstdial = CustomAlert(
            message: 'Hata',
            customTitle: 'Hata title',
            buttonName: 'Anladım',
            type: AlertType.Error,
            key: Key('TestAlerts'),
          );

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return cstdial;
            },
          );
          */

          //  ScaffoldMessenger.of(context).showSnackBar(sentSnack);
        });
      }
    });
  }

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
                      SizedBox(
                        child: cautionText && isLoading != true
                            ? Text(
                                "This room is not available",
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
