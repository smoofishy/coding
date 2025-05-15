import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, // White background
        body: Center(
          child: Container(
            width: 100, // Adjust size as needed
            height: 100,
            color: Colors.black, // Black box
          ),
        ),
      ),
    );
  }
}