// import 'package:calendar_date_picker2/src/widgets/_impl/calendar_picker/year/year_picker_barrel.dart';
import 'package:calendar_date_picker2/src/widgets/_impl/calendar_picker/year/year_picker_constants.dart';
import 'package:flutter/rendering.dart';

class YearPickerGridDelegate extends SliverGridDelegate {
  const YearPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth = (constraints.crossAxisExtent -
            (yearPickerColumnCount - 1) * yearPickerRowSpacing) /
        yearPickerColumnCount;

    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: yearPickerRowHeight,
      crossAxisCount: yearPickerColumnCount,
      crossAxisStride: tileWidth + yearPickerRowSpacing,
      mainAxisStride: yearPickerRowHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(YearPickerGridDelegate oldDelegate) => false;
}
