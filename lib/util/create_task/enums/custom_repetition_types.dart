import 'package:hyper_calendar/util/create_task/enums/reptition_end_type.dart';

import 'repetition_types.dart';

enum CustomRepetitionTypes {
  days,
  weeks,
  months,
  years,
}

String customRepetitionTypesToString(CustomRepetitionTypes type) {
  switch (type) {
    case CustomRepetitionTypes.days:
      return "Days";
    case CustomRepetitionTypes.months:
      return "Months";
    case CustomRepetitionTypes.weeks:
      return "Weeks";
    case CustomRepetitionTypes.years:
      return "Years";
    default:
      return "WHAT HAPPENED!";
  }
}

class CustomRepetition {
  CustomRepetitionTypes _type;
  CustomRepetitionTypes get type => _type;
  List<Days>? _dayList;
  List<Days>? get dayList => _dayList;
  final CustomRepetitionEnd _end = CustomRepetitionEnd();
  CustomRepetitionEnd get end => _end;

  //ONLY USE DAYLIST IF THE TYPE IS WEEKS
  CustomRepetition(this._type, [this._dayList]);

  void setDayList(List<Days> dayList) {
    _dayList = dayList;
  }

  void setType(CustomRepetitionTypes type) {
    _type = type;
    if (type != CustomRepetitionTypes.weeks) {
      _dayList = null;
    }
  }
}

class CustomRepetitionEnd {
  RepetitionEndType _type = RepetitionEndType.never;
  RepetitionEndType get type => _type;

  int? _occurences;
  int? get occurences => _occurences;
  DateTime? _stopDate;
  DateTime? get stopDate => _stopDate;

  void setRepetitionEndType(RepetitionEndType type) {
    _type = type;
  }

  void setOccurences(int? occurences) {
    _occurences = occurences;
  }

  void setStopDate(DateTime? stopDate) {
    _stopDate = stopDate;
  }
}
