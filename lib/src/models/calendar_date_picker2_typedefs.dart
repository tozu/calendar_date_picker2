import 'package:flutter/material.dart';

import 'package:calendar_date_picker2/src/models/models.dart';

/// Custom builder for the weekday label widget
typedef WeekdayLabelBuilder = Widget? Function({
  required int weekday,
  bool? isScrollViewTopHeader,
});

/// Custom builder for the day widget
typedef DayBuilder = Widget? Function({
  required DateTime date,
  TextStyle? textStyle,
  BoxDecoration? decoration,
  bool? isSelected,
  bool? isDisabled,
  bool? isToday,
});

/// Custom builder for the year widget
typedef YearBuilder = Widget? Function({
  required int year,
  TextStyle? textStyle,
  BoxDecoration? decoration,
  bool? isSelected,
  bool? isDisabled,
  bool? isCurrentYear,
});

/// Custom builder for the month widget
typedef MonthBuilder = Widget? Function({
  required int month,
  TextStyle? textStyle,
  BoxDecoration? decoration,
  bool? isSelected,
  bool? isDisabled,
  bool? isCurrentMonth,
});

/// Builder for the month and year in the scroll calendar view.
typedef ScrollViewMonthYearBuilder = Widget Function(DateTime monthDate);

/// Builder for the mode picker widget
///
/// [isMonthPicker] will be true if function is called to build month picker
typedef ModePickerBuilder = Widget? Function({
  required CalendarDatePicker2Mode viewMode,
  required DateTime monthDate,
  bool? isMonthPicker,
});

/// Predicate to determine the day widget box decoration for a day in selected range
typedef SelectedRangeDecorationPredicate = BoxDecoration? Function({
  required DateTime dayToBuild,
  required BoxDecoration decoration,
  required bool isStartDate,
  required bool isEndDate,
});

/// Function to provide full control over range picker highlight
typedef SelectedRangeHighlightBuilder = Widget? Function({
  required DateTime dayToBuild,
  required bool isStartDate,
  required bool isEndDate,
});

/// Handler for the text displayed in the mode picker
///
/// [isMonthPicker] will be true if function is called for month picker text
typedef ModePickerTextHandler = String? Function(
    {required DateTime monthDate, bool? isMonthPicker});

/// Callback for the scroll calendar view on scrolling
typedef ScrollViewOnScrolling = void Function(double offset);

/// Predicate to determine the text style for a day.
typedef DayTextStylePredicate = TextStyle? Function({
  required DateTime date,
});

/// Predicate to determine whether a year should be selectable.
typedef SelectableYearPredicate = bool Function(int year);

/// Predicate to determine whether a month should be selectable.
typedef SelectableMonthPredicate = bool Function(int year, int month);
