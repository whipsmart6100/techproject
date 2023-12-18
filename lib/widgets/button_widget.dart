// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required Key key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
        onPressed: onClicked,
        color: Color(0xFFFFFFFF),
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );

  RaisedButton(
      {required VoidCallback onPressed,
      required Color color,
      required StadiumBorder shape,
      required EdgeInsets padding,
      required Text child}) {}
}
