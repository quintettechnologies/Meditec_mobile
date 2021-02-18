import 'package:flutter/material.dart';

class TextAndField extends StatelessWidget {
  TextAndField({this.text, this.variable});
  final String text;
  var variable;
  bool isPassword = false;
  bool isEmail = false;
  @override
  Widget build(BuildContext context) {
    if (text == 'Email') {
      isEmail = true;
    } else if (text == 'Password') {
      isPassword = true;
    }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          child: TextFormField(
            onChanged: (value) {
              variable = value;
            },
            controller: TextEditingController(text: variable),
            validator: (value) {
              if (value.isEmpty) {
                return '$text is Empty';
              }
              return null;
            },
            style: TextStyle(
              fontSize: 16,
              height: 0.8,
              color: Colors.black,
            ),
            obscureText: isPassword,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter $text',
              hintStyle: TextStyle(fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
