import 'package:flutter/material.dart';

const k_mainColor = Color(0xFF0D47A1);

const kSendButtonTextStyle = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,

);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: k_mainColor, width: 2.0),
  ),
);

const kinputdecoration = InputDecoration(
  hintText: 'Enter your password.',
  hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: k_mainColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
