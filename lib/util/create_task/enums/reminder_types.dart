enum ReminderTypes {
  noReminder,
  min3,
  min5,
  min10,
  min15,
  min30,
  hour1,
  hour2,
  day1,
  week1,
}

String reminderTypesToString(ReminderTypes reminderType) {
  switch (reminderType) {
    case ReminderTypes.noReminder:
      return "No Reminder";
    case ReminderTypes.min3:
      return "3 Minutes";
    case ReminderTypes.min5:
      return "5 Minutes";
    case ReminderTypes.min10:
      return "10 Minutes";
    case ReminderTypes.min15:
      return "15 Minutes";
    case ReminderTypes.min30:
      return "30 Minutes";
    case ReminderTypes.hour1:
      return "1 Hour";
    case ReminderTypes.hour2:
      return "2 Hour";
    case ReminderTypes.day1:
      return "1 Day";
    case ReminderTypes.week1:
      return "1 Week";
    default:
      return "WHAT HAPPENED";
  }
}
