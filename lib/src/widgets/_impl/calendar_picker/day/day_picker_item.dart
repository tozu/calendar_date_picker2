import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:calendar_date_picker2/src/widgets/_focus_date.dart';
import 'package:calendar_date_picker2/src/widgets/_impl/calendar_picker/day/default_day_content.dart';
import 'package:calendar_date_picker2/src/widgets/_impl/calendar_picker/day/day_picker_constants.dart';
import 'package:flutter/material.dart';

class DayPickerItem extends StatefulWidget {
  final CalendarDatePicker2Config config;
  final List<DateTime> selectedDates;

  final int day;

  final ValueChanged<DateTime> onChanged;

  /// The month whose days are displayed by this picker.
  final DateTime displayedMonth;

  const DayPickerItem({
    Key? key,
    required this.config,
    required this.selectedDates,
    //
    required this.day,
    //
    required this.onChanged,
    //
    required this.displayedMonth,
  }) : super(key: key);

  @override
  State<DayPickerItem> createState() => _DayPickerItemState();
}

class _DayPickerItemState extends State<DayPickerItem> {
  /// List of [FocusNode]s, one for each day of the month.
  late List<FocusNode> _dayFocusNodes;

  @override
  void initState() {
    super.initState();
    final int daysInMonth = DateUtils.getDaysInMonth(
        widget.displayedMonth.year, widget.displayedMonth.month);
    _dayFocusNodes = List<FocusNode>.generate(
      daysInMonth,
      (int index) =>
          FocusNode(skipTraversal: true, debugLabel: 'Day ${index + 1}'),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check to see if the focused date is in this month, if so focus it.
    final DateTime? focusedDate = FocusedDate.maybeOf(context)?.date;
    if (focusedDate != null &&
        DateUtils.isSameMonth(widget.displayedMonth, focusedDate)) {
      _dayFocusNodes[focusedDate.day - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    for (final FocusNode node in _dayFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = MaterialLocalizations.of(context);

    // ---- Default colors

    final enabledDayColor = colorScheme.onSurface.withValues(alpha: 0.87);
    final disabledDayColor = colorScheme.onSurface.withValues(alpha: 0.38);
    final selectedDayColor = colorScheme.onPrimary;
    final selectedDayBackground = colorScheme.primary;
    final todayColor = colorScheme.primary;
    final daySplashColor = widget.config.daySplashColor ??
        selectedDayBackground.withValues(alpha: 0.38);

    // ---- Default textStyles
    final textTheme = Theme.of(context).textTheme;

    // final headerStyle = textTheme.bodySmall?.apply(
    //   color: colorScheme.onSurface.withValues(alpha: 0.60),
    // );

    final dayStyle = textTheme.bodySmall!;

    // ---

    final year = widget.displayedMonth.year;
    final month = widget.displayedMonth.month;

    final DateTime dayToBuild = DateTime(year, month, widget.day);

    final bool isDisabled = dayToBuild.isAfter(widget.config.lastDate) ||
        dayToBuild.isBefore(widget.config.firstDate) ||
        !(widget.config.selectableDayPredicate?.call(dayToBuild) ?? true);

    final bool isSelectedDay =
        widget.selectedDates.any((d) => DateUtils.isSameDay(d, dayToBuild));

    final bool isToday =
        DateUtils.isSameDay(widget.config.currentDate, dayToBuild);

    BoxDecoration? decoration;
    Color dayColor = enabledDayColor;

    if (isSelectedDay) {
      // The selected day gets a circle background highlight, and a
      // contrasting text color.
      dayColor = selectedDayColor;
      decoration = BoxDecoration(
        borderRadius: widget.config.dayBorderRadius,
        color: widget.config.selectedDayHighlightColor ?? selectedDayBackground,
        shape: widget.config.dayBorderRadius != null
            ? BoxShape.rectangle
            : BoxShape.circle,
      );
    } else if (isDisabled) {
      dayColor = disabledDayColor;
    } else if (isToday) {
      // The current day gets a different text color and a circle stroke
      // border.
      dayColor = widget.config.selectedDayHighlightColor ?? todayColor;
      decoration = BoxDecoration(
        borderRadius: widget.config.dayBorderRadius,
        border: Border.all(color: dayColor),
        shape: widget.config.dayBorderRadius != null
            ? BoxShape.rectangle
            : BoxShape.circle,
      );
    }

    var customDayTextStyle =
        widget.config.dayTextStylePredicate?.call(date: dayToBuild) ??
            widget.config.dayTextStyle;

    if (isToday && widget.config.todayTextStyle != null) {
      customDayTextStyle = widget.config.todayTextStyle;
    }

    if (isDisabled) {
      customDayTextStyle = customDayTextStyle?.copyWith(
        color: disabledDayColor,
        fontWeight: FontWeight.normal,
      );
      if (widget.config.disabledDayTextStyle != null) {
        customDayTextStyle = widget.config.disabledDayTextStyle;
      }
    }

    final isFullySelectedRangePicker =
        widget.config.calendarType == CalendarDatePicker2Type.range &&
            widget.selectedDates.length == 2;
    var isDateInBetweenRangePickerSelectedDates = false;

    if (isFullySelectedRangePicker) {
      final startDate = DateUtils.dateOnly(widget.selectedDates[0]);
      final endDate = DateUtils.dateOnly(widget.selectedDates[1]);

      isDateInBetweenRangePickerSelectedDates =
          !(dayToBuild.isBefore(startDate) || dayToBuild.isAfter(endDate)) &&
              !DateUtils.isSameDay(startDate, endDate);
    }

    if (isDateInBetweenRangePickerSelectedDates &&
        widget.config.selectedRangeDayTextStyle != null) {
      customDayTextStyle = widget.config.selectedRangeDayTextStyle;
    }

    if (isSelectedDay) {
      customDayTextStyle = widget.config.selectedDayTextStyle;
    }

    final dayTextStyle = customDayTextStyle ?? dayStyle.apply(color: dayColor);

    Widget dayWidget = widget.config.dayBuilder?.call(
          date: dayToBuild,
          textStyle: dayTextStyle,
          decoration: decoration,
          isSelected: isSelectedDay,
          isDisabled: isDisabled,
          isToday: isToday,
        ) ??
        DefaultDayContent(
          day: widget.day,
          decoration: decoration,
        );

    if (isDateInBetweenRangePickerSelectedDates) {
      final isStartDate = DateUtils.isSameDay(
          DateUtils.dateOnly(widget.selectedDates[0]), dayToBuild);
      final isEndDate = DateUtils.isSameDay(
          DateUtils.dateOnly(widget.selectedDates[1]), dayToBuild);
      var rangePickerIncludedDayDecoration = BoxDecoration(
        color: widget.config.selectedRangeHighlightColor ??
            (widget.config.selectedDayHighlightColor ?? selectedDayBackground)
                .withValues(alpha: 0.15),
      );
      if (widget.config.selectedRangeDecorationPredicate != null) {
        rangePickerIncludedDayDecoration =
            widget.config.selectedRangeDecorationPredicate?.call(
                  dayToBuild: dayToBuild,
                  decoration: rangePickerIncludedDayDecoration,
                  isStartDate: isStartDate,
                  isEndDate: isEndDate,
                ) ??
                rangePickerIncludedDayDecoration;
      }
      final rangePickerIncludedDayHighlight =
          widget.config.selectedRangeHighlightBuilder?.call(
        dayToBuild: dayToBuild,
        isStartDate: isStartDate,
        isEndDate: isEndDate,
      );

      if (isStartDate) {
        dayWidget = Stack(
          alignment: AlignmentDirectional.center,
          children: [
            rangePickerIncludedDayHighlight ??
                Row(children: [
                  const Spacer(),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.5,
                      child: Container(
                        decoration: rangePickerIncludedDayDecoration,
                      ),
                    ),
                  ),
                ]),
            dayWidget,
          ],
        );
      } else if (isEndDate) {
        dayWidget = Stack(
          alignment: AlignmentDirectional.center,
          children: [
            rangePickerIncludedDayHighlight ??
                Row(children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.5,
                      child: Container(
                        decoration: rangePickerIncludedDayDecoration,
                      ),
                    ),
                  ),
                  const Spacer(),
                ]),
            dayWidget,
          ],
        );
      } else {
        dayWidget = Stack(
          alignment: AlignmentDirectional.center,
          children: [
            rangePickerIncludedDayHighlight ??
                Row(children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: rangePickerIncludedDayDecoration,
                      ),
                    ),
                  ),
                ]),
            dayWidget,
          ],
        );
      }
    }

    dayWidget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: dayWidget,
    );

    if (isDisabled) {
      dayWidget = ExcludeSemantics(child: dayWidget);
    } else {
      var dayInkRadius = dayPickerRowHeight / 2 + 4;
      if (widget.config.dayMaxWidth != null) {
        dayInkRadius = (widget.config.dayMaxWidth! + 2) / 2 + 4;
      }
      dayWidget = InkResponse(
        focusNode: _dayFocusNodes[widget.day - 1],
        onTap: () => widget.onChanged(dayToBuild),
        radius: dayInkRadius,
        splashColor: daySplashColor,
        child: Semantics(
          // We want the day of month to be spoken first irrespective of the
          // locale-specific preferences or TextDirection. This is because
          // an accessibility user is more likely to be interested in the
          // day of month before the rest of the date, as they are looking
          // for the day of month. To do that we prepend day of month to the
          // formatted full date.
          label:
              '${localizations.formatDecimal(widget.day)}, ${localizations.formatFullDate(dayToBuild)}',
          selected: isSelectedDay,
          excludeSemantics: true,
          child: dayWidget,
        ),
      );
    }

    return dayWidget;
  }
}
