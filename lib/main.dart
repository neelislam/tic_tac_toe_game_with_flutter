import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game_with_flutter/screens/game.dart'; // Make sure this path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Optional: remove the debug banner
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue, // You can customize your theme
      ),
      home: gamePage(), // Use GamePage here as the home screen
    );
  }
}