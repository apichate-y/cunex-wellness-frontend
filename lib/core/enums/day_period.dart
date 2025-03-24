enum DayPeriod {
  earlyMorning,
  noon,
  evening,
  night,
}

DayPeriod getDayPeriod() {
  final hour = DateTime.now().hour;
  if (hour >= 6 && hour < 12) return DayPeriod.earlyMorning;
  if (hour >= 12 && hour < 17) return DayPeriod.noon;
  if (hour >= 17 && hour < 20) return DayPeriod.evening;
  return DayPeriod.night;
}
