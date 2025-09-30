import 'dart:math' as math;

import 'package:calendar_date_picker2/src/models/models.dart';
import 'package:calendar_date_picker2/src/widgets/_impl/calendar_picker/day/day_picker_constants.dart';
import 'package:flutter/rendering.dart';

class DayPickerGridDelegate extends SliverGridDelegate {
  const DayPickerGridDelegate({
    required this.config,
    required this.dayRowsCount,
  });

  /// The calendar configurations
  final CalendarDatePicker2Config? config;

  /// The number of rows to display in the day picker.
  final int dayRowsCount;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    var totalRowsCount = dayRowsCount + 1;
    if (config?.calendarViewMode == CalendarDatePicker2Mode.scroll &&
        config?.hideScrollViewMonthWeekHeader == true) {
      totalRowsCount -= 1;
    }
    var rowHeight = config?.dayMaxWidth != null
        ? (config!.dayMaxWidth! + 2)
        : dayPickerRowHeight;
    final double tileHeight = math.min(
      rowHeight,
      constraints.viewportMainAxisExtent / totalRowsCount,
    );
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: tileHeight,
      crossAxisCount: columnCount,
      crossAxisStride: tileWidth,
      mainAxisStride: tileHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(DayPickerGridDelegate oldDelegate) => false;
}
