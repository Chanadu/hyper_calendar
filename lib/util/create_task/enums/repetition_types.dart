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
      return 'Daily';
    case RepetitionTypes.weekly:
      return 'Weekly';
    case RepetitionTypes.monthly:
      return 'Monthly';
    case RepetitionTypes.yearly:
      return 'Yearly';
    case RepetitionTypes.custom:
      return 'Custom';
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
