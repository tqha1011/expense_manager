import 'package:flutter/material.dart';
class BuildWidget {
  static Widget buildSegment(String text) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(text, style: TextStyle(fontSize: 13.0)),
    );
  }
}