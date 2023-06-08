import 'package:flutter/material.dart';

import 'enums/custom_repetition_types.dart';
import 'enums/reminder_types.dart';
import 'enums/repetition_types.dart';

class NewTaskModel extends ChangeNotifier {
  String _eventName = 'A New Task';
  String get eventName => _eventName;
  String _description = "A short description of the new task.";
  String get description => _description;
  Color _color = Colors.blue;
  Color get color => _color;
  ReminderTypes _firstReminder = ReminderTypes.noReminder;
  ReminderTypes get firstReminder => _firstReminder;
  ReminderTypes _secondReminder = ReminderTypes.noReminder;
  ReminderTypes get secondReminder => _secondReminder;

  DateTime _startDate = DateUtils.dateOnly(DateTime.now());
  DateTime get startDate => _startDate;
  TimeOfDay _startTimeOfDay = TimeOfDay.now();
  TimeOfDay get startTimeOfDay => _startTimeOfDay;
  DateTime _endDate = DateUtils.dateOnly(DateTime.now());
  DateTime get endDate => _endDate;
  TimeOfDay _endTimeOfDay = TimeOfDay.now();
  TimeOfDay get endTimeOfDay => _endTimeOfDay;

  bool get isOneDayTask => _startDate.isAtSameMomentAs(_endDate);

  RepetitionTypes _repetitionState = RepetitionTypes.doesNotRepeat;
  RepetitionTypes get repetitionState => _repetitionState;

  final CustomRepetition _customRepetition = CustomRepetition(CustomRepetitionTypes.days);
  CustomRepetition get customRepetition => _customRepetition;

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

  void setRepetitionState(RepetitionTypes repetitionState) {
    _repetitionState = repetitionState;
    notifyListeners();
  }

  void setFirstReminder(ReminderTypes firstReminder) {
    _firstReminder = firstReminder;
    notifyListeners();
  }

  void setSecondReminder(ReminderTypes secondReminder) {
    _secondReminder = secondReminder;
    notifyListeners();
  }
}
