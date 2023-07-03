import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'sensitive-info/mongo_db_info.dart';
import 'util/enums/custom_repetition_types.dart';
import 'util/enums/reminder_types.dart';
import 'util/enums/repetition_types.dart';
import 'util/enums/reptition_end_type.dart';

class MongoDB {
  static Future<Db>? db;
  static DbCollection? coll;

  static Future<Db>? getDb() {
    if (coll == null || db == null) {
      return null;
    }
    return db;
  }

  static void start() async {
    db = Db.create(MongoDBInfo.connectionURL);
    (await db)!.open();
    coll = (await db!).collection(MongoDBInfo.collectionName);
  }

  static Future<String> insert(MongoDbModel model) async {
    try {
      WriteResult result = await coll!.insertOne(model.toJSON());
      if (result.isSuccess) {
        return 'Successfully Added Event!';
      } else {
        return 'Something went wrong. Try again later.';
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

  Map<String, dynamic> toJSON() => {
        '_id': id,
        'eventName': eventName,
        'description': description,
        'color': color.value,
        'reminders': {
          'first': firstReminder.toString(),
          'second': secondReminder.toString(),
        },
        'start': {
          'date': {
            'year': startDate.year,
            'month': startDate.month,
            'day': startDate.day,
          },
          'time': {
            'hour': startTime.hour,
            'minute': startTime.minute,
          },
        },
        'end': {
          'date': {
            'year': endDate.year,
            'month': endDate.month,
            'day': endDate.day,
          },
          'time': {
            'hour': endTime.hour,
            'minute': endTime.minute,
          },
        },
        'repetition': {
          'state': repetitionState.toString(),
          'custom': {
            'type': customRepetitionType.toString(),
            'duration': customRepetitionDuration,
            'dayList': {
              'sunday': customRepetitionDayList.contains(Days.sunday) ? true : false,
              'monday': customRepetitionDayList.contains(Days.monday) ? true : false,
              'tuesday': customRepetitionDayList.contains(Days.tuesday) ? true : false,
              'wednesday': customRepetitionDayList.contains(Days.wednesday) ? true : false,
              'thursday': customRepetitionDayList.contains(Days.thursday) ? true : false,
              'friday': customRepetitionDayList.contains(Days.friday) ? true : false,
              'saturday': customRepetitionDayList.contains(Days.saturday) ? true : false,
            },
            'end': {
              'type': customRepetitionEndType.toString(),
              'occurences': customRepetitionEndTypeOccurences,
              'date': {
                'year': customRepetitionEndTypeStopDate?.year,
                'month': customRepetitionEndTypeStopDate?.month,
                'day': customRepetitionEndTypeStopDate?.day,
              }
            }
          },
        },
      };
}
