import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'sensitive-info/mongo_db_info.dart';
import 'util/create_task/enums/custom_repetition_types.dart';
import 'util/create_task/enums/reminder_types.dart';
import 'util/create_task/enums/repetition_types.dart';
import 'util/create_task/enums/reptition_end_type.dart';

class MongoDB {
  static late Db db;
  static late DbCollection coll;

  static void start() async {
    db = await Db.create(MongoDBInfo.connectionURL);
    await db.open();
    coll = db.collection(MongoDBInfo.collectionName);
  }

  static Future<String> insert(MongoDbModel model) async {
    try {
      WriteResult result = await coll.insertOne(model.toJSON());
      if (result.isSuccess) {
        return "Successfully added Event";
      } else {
        return "Something went wrong. Try again later.";
      }
    } catch (e) {
      return e.toString();
    }
  }
}

class MongoDbModel {
  late ObjectId id;
  String eventName;
  String description;
  Color color;

  ReminderTypes reminder1;
  ReminderTypes reminder2;

  DateTime startDate;
  TimeOfDay startTime;

  DateTime endDate;
  TimeOfDay endTime;

  RepetitionTypes repetitionState;

  CustomRepetitionTypes customRepetitionType;
  List<Days> customRepetitionDayList;

  RepetitionEndType customRepetitionEndType;
  int? customRepetitionDuration;
  int? customRepetitionEndTypeOccurences;
  DateTime? customRepetitionEndTypeStopDate;

  MongoDbModel(
    this.eventName,
    this.description,
    this.color,
    this.reminder1,
    this.reminder2,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.repetitionState,
    this.customRepetitionType,
    this.customRepetitionDayList,
    this.customRepetitionEndType, [
    this.customRepetitionDuration,
    this.customRepetitionEndTypeOccurences,
    this.customRepetitionEndTypeStopDate,
  ]) {
    id = ObjectId();
  }
  Map<String, dynamic> toJSON() => {
        "_id": id,
        "eventName": eventName,
        "description": description,
        "color": color.value,
        "reminders": {
          "first": reminder1.toString(),
          "second": reminder2.toString(),
        },
        "start": {
          "date": {
            "year": startDate.year,
            "month": startDate.month,
            "day": startDate.day,
          },
          "time": {
            "hour": startTime.hour,
            "minute": startTime.minute,
          },
        },
        "end": {
          "date": {
            "year": endDate.year,
            "month": endDate.month,
            "day": endDate.day,
          },
          "time": {
            "hour": endTime.hour,
            "minute": endTime.minute,
          },
        },
        "repetition": {
          "state": repetitionState.toString(),
          "custom": {
            "type": customRepetitionType.toString(),
            "duration": customRepetitionDuration,
            "dayList": {
              "sunday": customRepetitionDayList.contains(Days.sunday) ? true : false,
              "monday": customRepetitionDayList.contains(Days.monday) ? true : false,
              "tuesday": customRepetitionDayList.contains(Days.tuesday) ? true : false,
              "wednesday": customRepetitionDayList.contains(Days.wednesday) ? true : false,
              "thursday": customRepetitionDayList.contains(Days.thursday) ? true : false,
              "friday": customRepetitionDayList.contains(Days.friday) ? true : false,
              "saturday": customRepetitionDayList.contains(Days.saturday) ? true : false,
            },
            "end": {
              "type": customRepetitionEndType.toString(),
              "occurences": customRepetitionEndTypeOccurences,
              "date": {
                "year": customRepetitionEndTypeStopDate?.year,
                "month": customRepetitionEndTypeStopDate?.month,
                "day": customRepetitionEndTypeStopDate?.day,
              }
            }
          },
        },
      };
}
