import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final String name;
  MyButton({this.name, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          name,
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
        ),
        color: Colors.greenAccent[700],
        onPressed: onPressed,
      ),
    );
  }
}
