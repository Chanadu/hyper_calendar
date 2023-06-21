import 'package:flutter/material.dart';

import 'create_task/enums/custom_repetition_types.dart';
import 'create_task/enums/reminder_types.dart';
import 'create_task/enums/repetition_types.dart';
import 'create_task/enums/reptition_end_type.dart';

class NewTaskModel extends ChangeNotifier {
  String _eventName = 'A New Task';
  String get eventName => _eventName;
  String _description = 'A short description of the new task.';
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

  CustomRepetitionTypes _customRepetitionType = CustomRepetitionTypes.days;
  CustomRepetitionTypes get customRepetitionType => _customRepetitionType;
  late List<Days> _customRepetitionDayList = [Days.values[_startDate.weekday % 7]];
  List<Days> get customRepetitionDayList => _customRepetitionDayList;
  RepetitionEndType _customRepetitionEndType = RepetitionEndType.never;
  RepetitionEndType get customRepetitionEndType => _customRepetitionEndType;

  int _customRepetitionDuration = 1;
  int get customRepetitionDuration => _customRepetitionDuration;
  int? _customRepetitionEndTypeOccurences;
  int? get customRepetitionEndTypeOccurences => _customRepetitionEndTypeOccurences;
  DateTime? _customRepetitionEndTypeStopDate;
  DateTime? get customRepetitionEndTypeStopDate => _customRepetitionEndTypeStopDate;

  void setStartDate(DateTime startDate) {
    _startDate = DateUtils.dateOnly(startDate);
    if (isOneDayTask && _customRepetitionDayList.isEmpty && _customRepetitionType == CustomRepetitionTypes.weeks) {
      _customRepetitionDayList = [Days.values[_startDate.weekday]];
    }
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

  void setCustomRepetitionDayList(List<Days> dayList) {
    _customRepetitionDayList = dayList;
    notifyListeners();
  }

  void addDayToCustomRepetitionDayList(Days day) {
    _customRepetitionDayList.add(day);
    notifyListeners();
  }

  void removeDayToCustomRepetitionDayList(Days day) {
    _customRepetitionDayList.remove(day);
    notifyListeners();
  }

  void setCustomRepetitionType(CustomRepetitionTypes type) {
    _customRepetitionType = type;
    if (type != CustomRepetitionTypes.weeks) {
      _customRepetitionDayList = [Days.values[_startDate.weekday % 7]];
    }
    notifyListeners();
  }

  void setCustomRepetitionEndType(RepetitionEndType type) {
    _customRepetitionEndType = type;
    notifyListeners();
  }

  void setCustomRepetitionEndTypeOccurences(int? occurences) {
    _customRepetitionEndTypeOccurences = occurences;
    notifyListeners();
  }

  void setCustomRepetitionEndTypeStopDate(DateTime? stopDate) {
    _customRepetitionEndTypeStopDate = stopDate;
    notifyListeners();
  }

  void setCustomRepetitionDuration(int duration) {
    _customRepetitionDuration = duration;
  }
}
