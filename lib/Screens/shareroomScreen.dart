import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secured_chat_app/constants.dart';
import 'package:flutter/services.dart';

class ShareRoomScreen extends StatefulWidget {
  final roomName;
  ShareRoomScreen({this.roomName});
  @override
  _ShareRoomScreenState createState() => _ShareRoomScreenState(roomName);
}

class _ShareRoomScreenState extends State<ShareRoomScreen> {
  bool isCopied = false;

  void copy()
  {
    Clipboard.setData(ClipboardData(text: "your text"));
    setState(() {
      isCopied = true;
    });
  }


  final roomName;
  _ShareRoomScreenState(this.roomName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: k_mainColor,
      ),
      body: Center(
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
              text: TextSpan(
              text: 'Your group name :  ',
              style: TextStyle(
              color: Colors.black, fontSize: 18),
    children: <TextSpan>[
    TextSpan(text: roomName,
    style: TextStyle(
    color: k_mainColor, fontSize: 20 , fontWeight: FontWeight.bold),


    )
    ]
              )
    ),
            SizedBox(height: 20),
              IconButton(icon: Icon(Icons.copy),onPressed:() => isCopied == false ?  copy() : null, color: k_mainColor, iconSize: 30, ),

              SizedBox(height: 80, child: isCopied ? Text("Coppied !!\nNow you can send chat name\n to your friends",style: TextStyle(
                  color: Colors.red,

                  fontWeight: FontWeight.bold,
                  fontSize: 18),textAlign: TextAlign.center,) : null)

            ],
          ),
        ),
      ),
    );
  }
}
