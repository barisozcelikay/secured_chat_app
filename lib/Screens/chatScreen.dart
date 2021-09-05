import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secured_chat_app/Screens/joinchatScreen.dart';
import 'package:secured_chat_app/Screens/shareroomScreen.dart';
import 'package:secured_chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'homeScreen.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";
  const ChatScreen({Key? key, this.chatName}) : super(key: key);
  final chatName; // widgetç diyerek ulasabiliyorum

  @override
  _ChatScreenState createState() => _ChatScreenState(chatName);
}

class _ChatScreenState extends State<ChatScreen> {
  late final chatName;
  _ChatScreenState(this.chatName);

  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  late String messageText;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: k_mainColor,
          leading: Builder(
            builder: (context) => IconButton(
              icon:
                  Hero(tag: "yildiz", child: Image.asset('images/YILDIZ.png')),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ), // Hero(tag: 'yildiz', child: Image.asset("images/YILDIZ.png")),
          title: Text("Chat Screen"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20), child: Icon(Icons.power))
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(
                cName: widget.chatName,
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          //Do something with the user input.
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        messageTextController.clear();
                        //Implement send functionality.
                        _firestore.collection(chatName).add({
                          'text': messageText,
                          'sender': loggedInUser.email
                        });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: k_mainColor,
                ),
                title: Text("Home"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.id, (Route<dynamic> route) => false);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.share,
                  color: k_mainColor,
                ),
                title: Text("Share"),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (ShareRoomScreen(
                      roomName: chatName,
                    )))),
              ),
              ListTile(
                leading: Icon(
                  Icons.change_circle,
                  color: k_mainColor
                ),
                title: Text("Change Room"),
                onTap: () => Navigator.pushNamed(context, JoinChat.id),
                
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key, required this.cName}) : super(key: key);
  final String cName;

  // !!!!!!!!!!!!!!!!
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(cName).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.get("text");
          final messageSender = message.get("sender");

          final currenUser = loggedInUser.email;
          if (currenUser == messageSender) {
            // This is ME
          }

          final messageBubble = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: currenUser == messageSender,
          );
          if (messageBubble != "" && messageSender != "") {
            messageBubbles.add(messageBubble);
          }
        }

        return Expanded(
            child: ListView(reverse: true, children: messageBubbles));
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isMe});

  final sender;
  final text;
  final isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
                fontWeight: FontWeight.w400),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            elevation: 10.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white54,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20.0,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
