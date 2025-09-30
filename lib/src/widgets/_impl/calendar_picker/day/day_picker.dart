import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:calendar_date_picker2/src/widgets/_impl/calendar_picker/calendar_picker_constants.dart';
import 'package:flutter/material.dart';

import 'weekday_header.dart';
import 'day_picker_grid_delegate.dart';
import 'day_picker_item.dart';

/// Displays the days of a given month and allows choosing a day.
///
/// The days are arranged in a rectangular grid with one column for each day of
/// the week.
class DayPicker extends StatefulWidget {
  /// Creates a day picker.
  const DayPicker({
    required this.config,
    required this.displayedMonth,
    required this.selectedDates,
    required this.onChanged,
    // required this.dayRowsCount,
    Key? key,
  }) : super(key: key);

  /// The calendar configurations
  final CalendarDatePicker2Config config;

  /// The currently selected dates.
  ///
  /// Selected dates are highlighted in the picker.
  final List<DateTime> selectedDates;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// The month whose days are displayed by this picker.
  final DateTime displayedMonth;

  // /// The number of rows to display in the day picker.
  // final int dayRowsCount;

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  /// Builds widgets showing abbreviated days of week. The first widget in the
  /// returned list corresponds to the first day of week for the current locale.
  ///
  /// Examples:
  ///
  /// ```
  /// ┌ Sunday is the first day of week in the US (en_US)
  /// |
  /// S M T W T F S  <-- the returned list contains these widgets
  /// _ _ _ _ _ 1 2
  /// 3 4 5 6 7 8 9
  ///
  /// ┌ But it's Monday in the UK (en_GB)
  /// |
  /// M T W T F S S  <-- the returned list contains these widgets
  /// _ _ _ _ 1 2 3
  /// 4 5 6 7 8 9 10
  /// ```
  List<Widget> _weekdayHeaders(
    List<String> weekdays,
    int firstDayOfWeek,
  ) {
    final List<Widget> result = <Widget>[];

    assert(firstDayOfWeek >= 0 && firstDayOfWeek <= 6,
        'firstDayOfWeek must between 0 and 6');

    for (int i = firstDayOfWeek; true; i = (i + 1) % 7) {
      final String weekday = weekdays[i];
      result.add(
        WeekdayHeader(
          config: widget.config,
          weekday: i,
          weekdayLabel: weekday,
        ),
      );
      if (i == (firstDayOfWeek - 1) % 7) break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    final year = widget.displayedMonth.year;
    final month = widget.displayedMonth.month;

    final firstDayOfWeek =
        widget.config.firstDayOfWeek ?? localizations.firstDayOfWeekIndex;

    final dayOffset = getMonthFirstDayOffset(year, month, firstDayOfWeek);

    final weekdays =
        widget.config.weekdayLabels ?? localizations.narrowWeekdays;

    final dayItems = _weekdayHeaders(weekdays, firstDayOfWeek);

    if (widget.config.calendarViewMode == CalendarDatePicker2Mode.scroll &&
        widget.config.hideScrollViewMonthWeekHeader == true) {
      dayItems.clear();
    }
    // 1-based day of month, e.g. 1-31 for January, and 1-29 for February on
    // a leap year.
    int day = -dayOffset;

    while (day < DateUtils.getDaysInMonth(year, month)) {
      day++;
      if (day < 1) {
        dayItems.add(Container());
      } else {
        final dayWidget = DayPickerItem(
          config: widget.config,
          selectedDates: widget.selectedDates,
          day: day,
          onChanged: widget.onChanged,
          displayedMonth: widget.displayedMonth,
        );

        dayItems.add(dayWidget);
      }
    }

    final dayRowsCount = widget.config.dynamicCalendarRows == true
        ? getDayRowsCount(
            year,
            month,
            widget.config.firstDayOfWeek ?? localizations.firstDayOfWeekIndex,
          )
        : maxDayPickerRowCount;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultHorizontalPadding,
      ),
      child: GridView.custom(
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        gridDelegate: DayPickerGridDelegate(
          config: widget.config,
          dayRowsCount: dayRowsCount,
        ),
        childrenDelegate: SliverChildListDelegate(
          dayItems,
          addRepaintBoundaries: false,
        ),
      ),
    );
  }
}
