import 'package:flutter/material.dart';

class InputWidgets extends StatelessWidget {
  const InputWidgets(
      {Key? key,
      required this.phoneController,
      required this.hintString,
      required this.labelString})
      : super(key: key);

  final TextEditingController phoneController;
  final labelString;
  final hintString;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: phoneController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                borderSide: BorderSide(color: Colors.red, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                borderSide: BorderSide(color: Colors.red, width: 2)),
            labelText: labelString,
            labelStyle: TextStyle(color: Colors.red, fontSize: 20),
            hintText: hintString),
      ),
    );
  }
}
