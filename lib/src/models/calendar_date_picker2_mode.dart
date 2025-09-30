/// Custom enum for a date picker mode including day, month, and year.
enum CalendarDatePicker2Mode {
  /// Choosing a day.
  day,

  /// Choosing a month.
  month,

  /// Choosing a year.
  year,

  /// Choosing a vertically scrollable calendar.
  ///
  /// The calendar must be wrapped inside a height-constrained widget
  scroll,
}
