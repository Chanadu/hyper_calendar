enum RepetitionTypes {
  doesNotRepeat,
  daily,
  weekly,
  monthly,
  yearly,
  custom,
}

String repetitionTypesToString(RepetitionTypes type) {
  switch (type) {
    case RepetitionTypes.doesNotRepeat:
      return 'Does not Repeat';
    case RepetitionTypes.daily:
      return 'Daily Repetition';
    case RepetitionTypes.weekly:
      return 'Weekly Repetition';
    case RepetitionTypes.monthly:
      return 'Monthly Repetition';
    case RepetitionTypes.yearly:
      return 'Yearly Repetition';
    case RepetitionTypes.custom:
      return 'Custom Repetition';
    default:
      return 'WHAT HAPPENED!';
  }
}

enum Days {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}
