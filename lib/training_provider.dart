import 'package:flutter/material.dart';
import 'package:my_training_app/training_model.dart';
import 'dummy_data.dart';

class TrainingProvider with ChangeNotifier {
  List<Training> _trainings = [];
  List<Training> _filteredTrainings = [];

  TrainingProvider() {
    // Initialize with dummy data
    setTrainings(dummyTrainings);
  }

  void setTrainings(List<Training> trainings) {
    _trainings = trainings;
    _filteredTrainings = trainings;
    notifyListeners();
  }

  List<Training> get filteredTrainings => _filteredTrainings;

  void filterTrainings(String location, String trainer) {
    _filteredTrainings = _trainings.where((training) {
      return (location.isEmpty || training.location.contains(location)) &&
          (trainer.isEmpty || training.trainer.contains(trainer));
    }).toList();
    notifyListeners();
  }
}
