enum CustomRepetitionTypes {
  days,
  weeks,
  months,
  years,
}

String customRepetitionTypesToString(CustomRepetitionTypes type) {
  switch (type) {
    case CustomRepetitionTypes.days:
      return 'Days';
    case CustomRepetitionTypes.months:
      return 'Months';
    case CustomRepetitionTypes.weeks:
      return 'Weeks';
    case CustomRepetitionTypes.years:
      return 'Years';
    default:
      return 'WHAT HAPPENED!';
  }
}
