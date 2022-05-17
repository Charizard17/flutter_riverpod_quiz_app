import 'package:flutter/material.dart';

import 'screens/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      home: QuizScreen(),
    );
  }
}
