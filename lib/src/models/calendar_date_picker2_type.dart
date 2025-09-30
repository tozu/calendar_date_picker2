/// Custom enum for a date picker type including single, multi, and range.
enum CalendarDatePicker2Type {
  /// Allows selecting a single date.
  single,

  /// Allows selecting multiple dates.
  multi,

  /// Allows selecting a range of two dates.
  ///
  /// See also [CalendarDatePicker2Config.rangeBidirectional].
  range,
}
