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
  static DbCollection? eventsColl;
  static DbCollection? authenticationColl;
  static DbCollection? singleDeleteOccurencesColl;

  static Future<Db>? getDb() {
    if (eventsColl == null || db == null) {
      return null;
    }
    return db;
  }

  static void start() async {
    db = Db.create(MongoDBInfo.connectionURL);
    (await db)!.open();
    eventsColl = (await db!).collection(MongoDBInfo.eventCollectionName);
    authenticationColl = (await db!).collection(MongoDBInfo.authenticationCollectionName);
    singleDeleteOccurencesColl = (await db!).collection(MongoDBInfo.singleDeleteOccurencesCollectionName);
  }

  static Future<String> insertEvent(MongoDbEventModel model) async {
    try {
      WriteResult result = await eventsColl!.insertOne(model.toJSON());
      if (result.isSuccess) {
        return 'Successfully Added Event!';
      } else {
        return 'Something went wrong. Try again later.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> insertAuthentication(MongoDbAuthenticationModel model) async {
    try {
      WriteResult result = await authenticationColl!.insertOne(model.toJSON());
      if (result.isSuccess) {
        return 'Successfully Added Account!';
      } else {
        return 'Something went wrong. Try again later.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> insertSingleDeleteOccurences(MongoDbSingleDeleteOccurencesModel model, String eventName) async {
    try {
      WriteResult result = await singleDeleteOccurencesColl!.insertOne(model.toJSON());
      if (result.isSuccess) {
        return 'Successfully Deleted Occurence of $eventName!';
      } else {
        return 'Something went wrong. Try again later.';
      }
    } catch (e) {
      return e.toString();
    }
  }
}

class MongoDbEventModel {
  late ObjectId id;
  late ObjectId userId;
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

  MongoDbEventModel({
    ObjectId? objectId,
    required this.userId,
    required this.eventName,
    required this.description,
    required this.color,
    required this.firstReminder,
    required this.secondReminder,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.repetitionState,
    required this.customRepetitionType,
    required this.customRepetitionDayList,
    required this.customRepetitionEndType,
    this.customRepetitionDuration,
    this.customRepetitionEndTypeOccurences,
    this.customRepetitionEndTypeStopDate,
  }) {
    id = objectId ?? ObjectId();
  }

  Map<String, dynamic> toJSON() => {
        '_id': id,
        'userId': userId,
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

class MongoDbAuthenticationModel {
  late ObjectId id;
  late String username;
  late String password;
  MongoDbAuthenticationModel({
    ObjectId? id,
    required this.username,
    required this.password,
  }) {
    this.id = id ?? ObjectId();
  }

  Map<String, dynamic> toJSON() => {
        '_id': id,
        'username': username,
        'password': password,
      };
}

class MongoDbSingleDeleteOccurencesModel {
  late ObjectId id;
  late ObjectId eventId;
  late DateTime date;

  MongoDbSingleDeleteOccurencesModel({
    ObjectId? id,
    required this.eventId,
    required this.date,
  }) {
    this.id = id ?? ObjectId();
  }

  Map<String, dynamic> toJSON() => {
        '_id': id,
        'eventId': eventId,
        'date': {
          'year': date.year,
          'month': date.month,
          'day': date.day,
        }
      };
}
