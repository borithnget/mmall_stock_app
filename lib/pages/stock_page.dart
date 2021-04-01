import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StockPage extends StatelessWidget{
  StockPage({this.color,this.title,this.onPush});
  final MaterialColor color;
  final String title;
  final ValueChanged<int> onPush;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
          backgroundColor: color,
        ),
        body: Container(
          color: Colors.white,
          child: Text(title),
        ));
  }

}