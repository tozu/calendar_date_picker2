import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:calendar_date_picker2/src/widgets/_focus_date.dart';
import 'package:calendar_date_picker2/src/widgets/_impl/calendar_picker/month/month_picker.dart';
import 'package:calendar_date_picker2/src/widgets/_impl/calendar_picker/year/year_picker.dart';
import 'package:calendar_date_picker2/src/widgets/_impl/calendar_picker/day/day_picker.dart';
import 'package:calendar_date_picker2/src/widgets/_impl/calendar_picker/calendar_picker_constants.dart';

import 'package:flutter/material.dart' hide YearPicker;
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

part '_calendar_scroll_view.dart';
part '_calendar_scroll_month.dart';
part '_calendar_view.dart';

part '../../buttons/month_control_buttons.dart';
part '../../buttons/month_selection_button.dart';

class CalendarViewPicker extends StatelessWidget {
  final CalendarDatePicker2Mode mode;
  final CalendarDatePicker2Config config;

  final List<DateTime?> selectedDates;

  final DateTime currentDisplayedMonthDate;

  final ValueChanged<DateTime> onDayChanged;
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<DateTime> onYearChanged;
  final ValueChanged<DateTime> onDisplayedMonthChanged;

  CalendarViewPicker({
    required this.mode,
    required this.config,
    required this.selectedDates,
    required this.currentDisplayedMonthDate,
    required this.onDayChanged,
    required this.onMonthChanged,
    required this.onYearChanged,
    required this.onDisplayedMonthChanged,
    Key? key,
  }) : super(key: key);

  final GlobalKey _dayPickerKey = GlobalKey();
  final GlobalKey _monthPickerKey = GlobalKey();
  final GlobalKey _yearPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case CalendarDatePicker2Mode.day:
        return _CalendarView(
          config: config,
          key: _dayPickerKey,
          initialMonth: currentDisplayedMonthDate,
          selectedDates: selectedDates,
          onChanged: onDayChanged,
          onDisplayedMonthChanged: onDisplayedMonthChanged,
        );
      case CalendarDatePicker2Mode.month:
        return Padding(
          padding: EdgeInsets.only(
              top: config.controlsHeight ?? defaultHeaderHeight),
          child: MonthPicker(
            config: config,
            key: _monthPickerKey,
            initialMonth: currentDisplayedMonthDate,
            selectedDates: selectedDates,
            onChanged: onMonthChanged,
          ),
        );
      case CalendarDatePicker2Mode.year:
        return Padding(
          padding: EdgeInsets.only(
              top: config.controlsHeight ?? defaultHeaderHeight),
          child: YearPicker(
            config: config,
            key: _yearPickerKey,
            initialMonth: currentDisplayedMonthDate,
            selectedDates: selectedDates,
            onChanged: onYearChanged,
          ),
        );
      case CalendarDatePicker2Mode.scroll:
        return Container(
          constraints: config.scrollViewConstraints,
          child: _CalendarScrollView(
            config: config,
            key: _dayPickerKey,
            initialMonth: currentDisplayedMonthDate,
            selectedDates: selectedDates,
            onChanged: onDayChanged,
            onDisplayedMonthChanged: onDisplayedMonthChanged,
          ),
        );
    }
  }
}
