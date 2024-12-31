import 'package:flutter/material.dart';
import 'package:my_training_app/training_model.dart';

class TrainingDetailsScreen extends StatelessWidget {
  final Training training;

  const TrainingDetailsScreen({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(training.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(training.title, style: const TextStyle(fontSize: 24)),
            Text(training.location),
            Text(training.date),
            Text(training.trainer),
            Text("Price: ${training.price}"),
          ],
        ),
      ),
    );
  }
}
