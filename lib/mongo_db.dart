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
        return "Successfully Added Event!";
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

  ReminderTypes firstReminder;
  ReminderTypes secondReminder;

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
    this.firstReminder,
    this.secondReminder,
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

  MongoDbModel.fromJSON(Map<String, dynamic> json) {
    id = json["_id"];
    eventName = json["eventName"];
    description = json["description"];
    color = json["color"];
    firstReminder = json["reminders"]["first"];
    secondReminder = json["reminders"]["second"];
    startDate = DateTime(json["start"]["date"]["year"], json["start"]["date"]["month"], json["start"]["date"]["day"]);
    startTime = TimeOfDay(hour: json["start"]["time"]["hour"], minute: json["start"]["time"]["minute"]);
    endDate = DateTime(json["end"]["date"]["year"], json["end"]["date"]["month"], json["end"]["date"]["day"]);
    endTime = TimeOfDay(hour: json["endTime"]["time"]["hour"], minute: json["endTime"]["time"]["minute"]);
    repetitionState = json["repetition"]["state"];
  }

  Map<String, dynamic> toJSON() => {
        "_id": id,
        "eventName": eventName,
        "description": description,
        "color": color.value,
        "reminders": {
          "first": firstReminder.toString(),
          "second": secondReminder.toString(),
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

extension EnumParser on String {
  T? toEnum<T>(List<T?> values) {
    return values.firstWhere((e) => e.toString().toLowerCase().split(".").last == toLowerCase(), orElse: () => null); //return null if not found
  }
}
