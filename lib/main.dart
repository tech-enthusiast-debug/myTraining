import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'training_provider.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrainingProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Trainings App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: TrainingApp(),
      ),
    );
  }
}
