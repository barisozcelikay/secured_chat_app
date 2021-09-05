import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secured_chat_app/Screens/createchatScreen.dart';
import 'package:secured_chat_app/Screens/joinchatScreen.dart';
import 'package:secured_chat_app/Screens/loginScreen.dart';
import 'package:secured_chat_app/Screens/registrationScreen.dart';
import 'package:secured_chat_app/Screens/chatScreen.dart';
import 'package:secured_chat_app/Screens/homeScreen.dart';
import 'package:secured_chat_app/Screens/shareroomScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // !!!!!!!!
  await Firebase.initializeApp();
  runApp(MyApp());
}

ThemeData buildTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    hintColor: Colors.red,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.yellow, fontSize: 24.0),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Havelsan Chat',
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LogInScreen.id: (context) => LogInScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        JoinChat.id: (context) => JoinChat(),
        CreateChat.id: (context) => CreateChat(),
        ChatScreen.id: (context) => ChatScreen()
      },
      home: HomeScreen(),
    );
  }
}
