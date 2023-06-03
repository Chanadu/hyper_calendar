import 'package:flutter/material.dart';

class NewTaskModel extends ChangeNotifier {
  String _eventName = 'A New Task';
  String get eventName => _eventName;
  String _description = "A short description of the new task.";
  String get description => _description;
  Color _color = Colors.blue;
  Color get color => _color;

  DateTime _startDate = DateUtils.dateOnly(DateTime.now());
  DateTime get startDate => _startDate;
  TimeOfDay _startTimeOfDay = TimeOfDay.now();
  TimeOfDay get startTimeOfDay => _startTimeOfDay;
  DateTime _endDate = DateUtils.dateOnly(DateTime.now());
  DateTime get endDate => _endDate;
  TimeOfDay _endTimeOfDay = TimeOfDay.now();
  TimeOfDay get endTimeOfDay => _endTimeOfDay;

  bool get isOneDayTask => _startDate.isAtSameMomentAs(_endDate);

  void setStartDate(DateTime startDate) {
    _startDate = DateUtils.dateOnly(startDate);
    notifyListeners();
  }

  void setEndDate(DateTime endDate) {
    _endDate = DateUtils.dateOnly(endDate);
    notifyListeners();
  }

  void setStartTimeOfDay(TimeOfDay startTimeOfDay) {
    _startTimeOfDay = startTimeOfDay;
    notifyListeners();
  }

  void setEndTimeOfDay(TimeOfDay endTimeOfDay) {
    _endTimeOfDay = endTimeOfDay;
    notifyListeners();
  }

  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }

  void setEventName(String eventName) {
    _eventName = eventName;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }
}
