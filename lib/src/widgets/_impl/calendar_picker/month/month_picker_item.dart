import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class MonthPickerItem extends StatelessWidget {
  final CalendarDatePicker2Config config;

  final List<DateTime?> selectedDates;
  final DateTime initialMonth;

  final ValueChanged<DateTime> onTap;

  final int index;

  const MonthPickerItem(
    this.index, {
    required this.config,
    required this.selectedDates,
    required this.initialMonth,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final locale = Localizations.localeOf(context);

    final int month = 1 + index;
    final bool isCurrentMonth = initialMonth.year == config.currentDate.year &&
        config.currentDate.month == month;
    const double decorationHeight = 36.0;
    const double decorationWidth = 72.0;

    final bool isSelected = selectedDates.isNotEmpty &&
        selectedDates.any((date) =>
            date != null &&
            initialMonth.year == date.year &&
            date.month == month);
    var isMonthSelectable = initialMonth.year >= config.firstDate.year &&
        initialMonth.year <= config.lastDate.year;
    if (isMonthSelectable) {
      var isAfterFirst = true;
      var isBeforeLast = true;
      if (initialMonth.year == config.firstDate.year) {
        isAfterFirst = month >= config.firstDate.month;
      }

      if (initialMonth.year == config.lastDate.year) {
        isBeforeLast = month <= config.lastDate.month;
      }
      isMonthSelectable = isAfterFirst && isBeforeLast;
    }
    final monthSelectableFromPredicate =
        config.selectableMonthPredicate?.call(initialMonth.year, month) ?? true;
    isMonthSelectable = isMonthSelectable && monthSelectableFromPredicate;

    final Color textColor;
    if (isSelected) {
      textColor = colorScheme.onPrimary;
    } else if (!isMonthSelectable) {
      textColor = colorScheme.onSurface.withValues(alpha: 0.38);
    } else if (isCurrentMonth) {
      textColor = config.selectedDayHighlightColor ?? colorScheme.primary;
    } else {
      textColor = colorScheme.onSurface.withValues(alpha: 0.87);
    }

    TextStyle? itemStyle =
        config.monthTextStyle ?? textTheme.bodyLarge?.apply(color: textColor);
    if (!isMonthSelectable) {
      itemStyle = config.disabledMonthTextStyle ?? itemStyle;
    }
    if (isSelected) {
      itemStyle = config.selectedMonthTextStyle ?? itemStyle;
    }

    BoxDecoration? decoration;
    if (isSelected) {
      decoration = BoxDecoration(
        color: config.selectedDayHighlightColor ?? colorScheme.primary,
        borderRadius: config.monthBorderRadius ??
            BorderRadius.circular(decorationHeight / 2),
      );
    } else if (isCurrentMonth && isMonthSelectable) {
      decoration = BoxDecoration(
        border: Border.all(
          color: config.selectedDayHighlightColor ?? colorScheme.primary,
        ),
        borderRadius: config.monthBorderRadius ??
            BorderRadius.circular(decorationHeight / 2),
      );
    }

    Widget monthItem = config.monthBuilder?.call(
          month: month,
          textStyle: itemStyle,
          decoration: decoration,
          isSelected: isSelected,
          isDisabled: !isMonthSelectable,
          isCurrentMonth: isCurrentMonth,
        ) ??
        Center(
          child: Container(
            decoration: decoration,
            height: decorationHeight,
            width: decorationWidth,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Text(
                  getLocaleShortMonthFormat(locale)
                      .format(DateTime(initialMonth.year, month)),
                  style: itemStyle,
                ),
              ),
            ),
          ),
        );

    if (!isMonthSelectable) {
      monthItem = ExcludeSemantics(child: monthItem);
    } else {
      monthItem = InkWell(
        key: ValueKey<int>(month),
        onTap: !isMonthSelectable
            ? null
            : () {
                onTap(DateUtils.dateOnly(DateTime(initialMonth.year, month)));
              },
        child: monthItem,
      );
    }

    return monthItem;
  }
}
