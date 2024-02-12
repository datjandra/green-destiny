import 'package:flutter/material.dart';
import 'scenarios.dart';
import 'splash.dart';
import 'game.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Callback function to navigate to the GamePage
  void navigateToGamePage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => GamePage(scenarios: scenarios)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Destiny',
      theme: GreenDestinyTheme.lightThemeData,
      home: SplashScreen(
          navigateToGamePage), // Pass the callback function to SplashScreen,
    );
  }
}
