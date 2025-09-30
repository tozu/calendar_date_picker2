part of '../../_impl/calendar/calendar_view_picker.dart';

class _CalendarScrollMonth extends StatelessWidget {
  final CalendarDatePicker2Config config;
  final List<DateTime?> selectedDates;
  final ValueChanged<DateTime> onChanged;

  final int index;
  final bool beforeInitialMonth;

  final int initialMonthIndex;

  const _CalendarScrollMonth({
    required this.config,
    required this.selectedDates,
    required this.onChanged,
    required this.index,
    required this.initialMonthIndex,
    required this.beforeInitialMonth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final themeData = Theme.of(context);

    final colorScheme = themeData.colorScheme;
    final textTheme = themeData.textTheme;

    final controlColor = colorScheme.onSurface.withValues(alpha: 0.60);

    final monthIndex = beforeInitialMonth
        ? initialMonthIndex - index - 1
        : initialMonthIndex + index;

    final DateTime month =
        DateUtils.addMonthsToMonthDate(config.firstDate, monthIndex);

    final dayRowsCount = config.dynamicCalendarRows == true
        ? getDayRowsCount(
            month.year,
            month.month,
            config.firstDayOfWeek ?? localizations.firstDayOfWeekIndex,
          )
        : maxDayPickerRowCount;

    var totalRowsCount = dayRowsCount + 1;

    var rowHeight = config.dayMaxWidth != null
        ? (config.dayMaxWidth! + 2)
        : dayPickerRowHeight;

    if (config.calendarViewMode == CalendarDatePicker2Mode.scroll &&
        config.hideScrollViewMonthWeekHeader == true) {
      // Exclude header row
      totalRowsCount -= 1;
    }
    final maxContentHeight = rowHeight * totalRowsCount;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        config.scrollViewMonthYearBuilder?.call(month) ??
            Row(
              children: [
                if (config.centerAlignModePicker == true) const Spacer(),
                Container(
                  height: rowHeight,
                  margin: const EdgeInsets.symmetric(
                      horizontal: defaultHorizontalPadding),
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultHorizontalPadding),
                  child: Center(
                    child: Text(
                      config.modePickerTextHandler?.call(monthDate: month) ??
                          localizations.formatMonthYear(month),
                      style: config.controlsTextStyle ??
                          textTheme.titleSmall?.copyWith(color: controlColor),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),

        //
        SizedBox(
          height: maxContentHeight,
          child: DayPicker(
            key: ValueKey<DateTime>(month),
            config: config,
            selectedDates: selectedDates.whereType<DateTime>().toList(),
            displayedMonth: month,
            onChanged: onChanged,
            // dayRowsCount: dayRowsCount,
          ),
        ),
      ],
    );
  }
}
