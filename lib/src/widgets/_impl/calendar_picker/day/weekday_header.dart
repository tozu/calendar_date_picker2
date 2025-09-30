import 'package:calendar_date_picker2/src/models/models.dart';
import 'package:flutter/material.dart';

class WeekdayHeader extends StatelessWidget {
  final CalendarDatePicker2Config config;

  final int weekday;
  final String weekdayLabel;

  const WeekdayHeader({
    required this.config,
    required this.weekday,
    required this.weekdayLabel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final headerStyle = textTheme.bodySmall?.apply(
      color: colorScheme.onSurface.withValues(alpha: 0.60),
    );

    return ExcludeSemantics(
      child: config.weekdayLabelBuilder?.call(weekday: weekday) ??
          Center(
            child: Text(
              weekdayLabel,
              style: config.weekdayLabelTextStyle ?? headerStyle,
            ),
          ),
    );
  }
}
