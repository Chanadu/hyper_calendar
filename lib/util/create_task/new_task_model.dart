import 'package:flutter/material.dart';

// class NewTaskModel extends ChangeNotifier {
//   String eventName = 'A New Task';
//   String description = "A short description of the new task.";
//   Color color = Colors.blue;

//   DateTime startDate = DateTime.now();
//   TimeOfDay startTimeOfDay = TimeOfDay.now();
//   DateTime endDate = DateTime.now();
//   TimeOfDay endTimeOfDay = TimeOfDay.now();

//   bool get isOneDayTask => startDate.isAtSameMomentAs(endDate);

//   DateTime getStartDate() => startDate;
//   DateTime getEndDate() => endDate;
//   TimeOfDay getStartTimeOfDay() => startTimeOfDay;
//   TimeOfDay getEndTimeOfDay() => endTimeOfDay;
//   Color getColor() => color;
//   String getEventName() => eventName;
//   String getDescription() => description;

//   void setStartDate(DateTime startDate) {
//     this.startDate = startDate;
//     notifyListeners();
//   }

//   void setEndDate(DateTime endDate) {
//     this.endDate = endDate;
//     notifyListeners();
//   }

//   void setStartTimeOfDay(TimeOfDay startTimeOfDay) {
//     this.startTimeOfDay = startTimeOfDay;
//     notifyListeners();
//   }

//   void setEndTimeOfDay(TimeOfDay endTimeOfDay) {
//     this.endTimeOfDay = endTimeOfDay;
//     notifyListeners();
//   }

//   void setColor(Color color) {
//     this.color = color;
//     notifyListeners();
//   }

//   void setEventName(String eventName) {
//     this.eventName = eventName;
//     notifyListeners();
//   }

//   void setDescription(String description) {
//     this.description = description;
//     notifyListeners();
//   }
// }
