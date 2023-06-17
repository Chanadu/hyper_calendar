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
  late String eventName;
  late String description;
  late Color color;

  late ReminderTypes firstReminder;
  late ReminderTypes secondReminder;

  late DateTime startDate;
  late TimeOfDay startTime;

  late DateTime endDate;
  late TimeOfDay endTime;

  late RepetitionTypes repetitionState;

  late CustomRepetitionTypes customRepetitionType;
  late List<Days> customRepetitionDayList;

  late RepetitionEndType customRepetitionEndType;
  late int? customRepetitionDuration;
  late int? customRepetitionEndTypeOccurences;
  late DateTime? customRepetitionEndTypeStopDate;

  MongoDbModel(
    ObjectId? objectId,
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
    id = objectId ?? ObjectId();
  }

  factory MongoDbModel.fromJSON(Map<String, dynamic> json) {
    final ObjectId id = json["_id"] as ObjectId;
    final String eventName = json["eventName"] as String;
    final String description = json["description"] as String;
    final Color color = Color(json["color"] as int);
    final ReminderTypes firstReminder = json["reminders"]["first"] as ReminderTypes;
    final ReminderTypes secondReminder = json["reminders"]["second"] as ReminderTypes;
    final DateTime startDate = DateTime(json["start"]["date"]["year"] as int, json["start"]["date"]["month"] as int, json["start"]["date"]["day"] as int);
    final TimeOfDay startTime = TimeOfDay(hour: json["start"]["time"]["hour"] as int, minute: json["start"]["time"]["minute"] as int);
    final DateTime endDate = DateTime(json["end"]["date"]["year"] as int, json["end"]["date"]["month"] as int, json["end"]["date"]["day"] as int);
    final TimeOfDay endTime = TimeOfDay(hour: json["endTime"]["time"]["hour"] as int, minute: json["endTime"]["time"]["minute"] as int);
    final RepetitionTypes repetitionState = json["repetition"]["state"] as RepetitionTypes;
    final CustomRepetitionTypes customRepetitionType = json["repetition"]["custom"]["type"] as CustomRepetitionTypes;
    final List<Days> customRepetitionDayList = [];
    json["repetition"]["custom"]["dayList"]["sunday"] ? customRepetitionDayList.add(Days.sunday) : null;
    json["repetition"]["custom"]["dayList"]["monday"] ? customRepetitionDayList.add(Days.monday) : null;
    json["repetition"]["custom"]["dayList"]["tuesday"] ? customRepetitionDayList.add(Days.tuesday) : null;
    json["repetition"]["custom"]["dayList"]["wednesday"] ? customRepetitionDayList.add(Days.wednesday) : null;
    json["repetition"]["custom"]["dayList"]["thursday"] ? customRepetitionDayList.add(Days.thursday) : null;
    json["repetition"]["custom"]["dayList"]["friday"] ? customRepetitionDayList.add(Days.friday) : null;
    json["repetition"]["custom"]["dayList"]["saturday"] ? customRepetitionDayList.add(Days.saturday) : null;
    final customRepetitionEndType = json["repetition"]["custom"]["end"] as RepetitionEndType;
    final int? customRepetitionDuration = json["repetition"]["custom"]["duration"] as int?;
    int? customRepetitionEndTypeOccurences = json["repetition"]["custom"]["end"]["occurences"] as int?;
    DateTime? customRepetitionEndTypeStopDate = json["repetition"]["custom"]["end"]["date"]["year"] == null
        ? null
        : DateTime(
            json["repetition"]["custom"]["end"]["date"]["year"] as int,
            json["repetition"]["custom"]["end"]["date"]["month"] as int,
            json["repetition"]["custom"]["end"]["date"]["day"] as int,
          );
    return MongoDbModel(
      id,
      eventName,
      description,
      color,
      firstReminder,
      secondReminder,
      startDate,
      startTime,
      endDate,
      endTime,
      repetitionState,
      customRepetitionType,
      customRepetitionDayList,
      customRepetitionEndType,
      customRepetitionDuration,
      customRepetitionEndTypeOccurences,
      customRepetitionEndTypeStopDate,
    );
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
