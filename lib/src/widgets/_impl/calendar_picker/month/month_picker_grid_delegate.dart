import 'package:calendar_date_picker2/src/widgets/_impl/calendar_picker/month/month_picker_constants.dart';
import 'package:flutter/rendering.dart';

class MonthPickerGridDelegate extends SliverGridDelegate {
  const MonthPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth = (constraints.crossAxisExtent -
            (monthPickerColumnCount - 1) * monthPickerRowSpacing) /
        monthPickerColumnCount;
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: monthPickerRowHeight,
      crossAxisCount: monthPickerColumnCount,
      crossAxisStride: tileWidth + monthPickerRowSpacing,
      mainAxisStride: monthPickerRowHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(MonthPickerGridDelegate oldDelegate) => false;
}
