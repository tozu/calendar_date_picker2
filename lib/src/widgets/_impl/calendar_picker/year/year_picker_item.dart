import 'package:calendar_date_picker2/src/models/models.dart';
import 'package:flutter/material.dart';

class YearItem extends StatelessWidget {
  final CalendarDatePicker2Config config;

  final List<DateTime?> selectedDates;
  final DateTime initialMonth;
  final int minYears;

  final ValueChanged<DateTime> onTap;

  final int index;

  const YearItem(
    this.index, {
    required this.config,
    required this.selectedDates,
    required this.initialMonth,
    required this.minYears,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  int get itemCount => config.lastDate.year - config.firstDate.year + 1;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    // Backfill the _YearPicker with disabled years if necessary.
    final int offset = itemCount < minYears ? (minYears - itemCount) ~/ 2 : 0;
    final int year = config.firstDate.year + index - offset;
    final bool isSelected = selectedDates.any((d) => d?.year == year);
    final bool isCurrentYear = year == config.currentDate.year;
    final yearSelectableFromPredicate =
        config.selectableYearPredicate?.call(year) ?? true;
    final isDisabled =
        (year < config.firstDate.year || year > config.lastDate.year) ||
            !yearSelectableFromPredicate;
    const double decorationHeight = 36.0;
    const double decorationWidth = 72.0;

    final Color textColor;
    if (isSelected) {
      textColor = colorScheme.onPrimary;
    } else if (isDisabled) {
      textColor = colorScheme.onSurface.withValues(alpha: 0.38);
    } else if (isCurrentYear) {
      textColor = config.selectedDayHighlightColor ?? colorScheme.primary;
    } else {
      textColor = colorScheme.onSurface.withValues(alpha: 0.87);
    }
    TextStyle? itemStyle =
        config.yearTextStyle ?? textTheme.bodyLarge?.apply(color: textColor);
    if (isDisabled) {
      itemStyle = config.disabledYearTextStyle ?? itemStyle;
    }
    if (isSelected) {
      itemStyle = config.selectedYearTextStyle ?? itemStyle;
    }

    BoxDecoration? decoration;
    if (isSelected) {
      decoration = BoxDecoration(
        color: config.selectedDayHighlightColor ?? colorScheme.primary,
        borderRadius: config.yearBorderRadius ??
            BorderRadius.circular(decorationHeight / 2),
      );
    } else if (isCurrentYear && !isDisabled) {
      decoration = BoxDecoration(
        border: Border.all(
          color: config.selectedDayHighlightColor ?? colorScheme.primary,
        ),
        borderRadius: config.yearBorderRadius ??
            BorderRadius.circular(decorationHeight / 2),
      );
    }

    Widget yearItem = config.yearBuilder?.call(
          year: year,
          textStyle: itemStyle,
          decoration: decoration,
          isSelected: isSelected,
          isDisabled: isDisabled,
          isCurrentYear: isCurrentYear,
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
                  year.toString(),
                  style: itemStyle,
                ),
              ),
            ),
          ),
        );

    if (isDisabled) {
      yearItem = ExcludeSemantics(child: yearItem);
    } else {
      yearItem = InkWell(
        key: ValueKey<int>(year),
        onTap: () {
          onTap(DateTime(year, initialMonth.month));
        },
        child: yearItem,
      );
    }

    return yearItem;
  }
}
