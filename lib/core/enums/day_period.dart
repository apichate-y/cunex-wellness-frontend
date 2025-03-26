enum DayPeriod {
  earlyMorning,
  noon,
  evening,
  night,
}

DayPeriod getDayPeriod() {
  final hour = DateTime.now().hour;
  if (hour >= 5 && hour < 10) return DayPeriod.earlyMorning;
  if (hour >= 10 && hour < 15) return DayPeriod.noon;
  if (hour >= 15 && hour < 20) return DayPeriod.evening;
  return DayPeriod.night;
}
