import 'dart:math' as math;
import 'package:calendar_date_picker2/src/models/models.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide YearPicker;

import 'year_picker_constants.dart';
import 'year_picker_grid_delegate.dart';
import 'year_picker_item.dart';

/// A scrollable grid of years to allow picking a year.
///
/// The year picker widget is rarely used directly. Instead, consider using
/// [CalendarDatePicker2], or [showDatePicker2] which create full date pickers.
///
/// See also:
///
///  * [CalendarDatePicker2], which provides a Material Design date picker
///    interface.
///
///  * [showDatePicker2], which shows a dialog containing a Material Design
///    date picker.
///
class YearPicker extends StatefulWidget {
  /// Creates a year picker.
  const YearPicker({
    required this.config,
    required this.selectedDates,
    required this.onChanged,
    required this.initialMonth,
    this.dragStartBehavior = DragStartBehavior.start,
    Key? key,
  }) : super(key: key);

  /// The calendar configurations
  final CalendarDatePicker2Config config;

  /// The currently selected dates.
  ///
  /// Selected dates are highlighted in the picker.
  final List<DateTime?> selectedDates;

  /// Called when the user picks a year.
  final ValueChanged<DateTime> onChanged;

  /// The initial month to display.
  final DateTime initialMonth;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  @override
  State<YearPicker> createState() => _YearPickerState();
}

class _YearPickerState extends State<YearPicker> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final scrollOffset =
        widget.selectedDates.isNotEmpty && widget.selectedDates[0] != null
            ? _scrollOffsetForYear(widget.selectedDates[0]!)
            : _scrollOffsetForYear(DateUtils.dateOnly(DateTime.now()));
    _scrollController = widget.config.yearViewController ??
        ScrollController(initialScrollOffset: scrollOffset);
  }

  @override
  void didUpdateWidget(YearPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDates != oldWidget.selectedDates) {
      final scrollOffset =
          widget.selectedDates.isNotEmpty && widget.selectedDates[0] != null
              ? _scrollOffsetForYear(widget.selectedDates[0]!)
              : _scrollOffsetForYear(DateUtils.dateOnly(DateTime.now()));
      _scrollController.jumpTo(scrollOffset);
    }
  }

  double _scrollOffsetForYear(DateTime date) {
    final int initialYearIndex = date.year - widget.config.firstDate.year;
    final int initialYearRow = initialYearIndex ~/ yearPickerColumnCount;
    // Move the offset down by 2 rows to approximately center it.
    final int centeredYearRow = initialYearRow - 2;
    return _itemCount < minYears ? 0 : centeredYearRow * yearPickerRowHeight;
  }

  int get _itemCount {
    return widget.config.lastDate.year - widget.config.firstDate.year + 1;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return Column(
      children: <Widget>[
        Divider(
          color: widget.config.hideYearPickerDividers == true
              ? Colors.transparent
              : null,
        ),
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            dragStartBehavior: widget.dragStartBehavior,
            gridDelegate: const YearPickerGridDelegate(),
            itemBuilder: (context, index) => YearItem(
              index,
              config: widget.config,
              selectedDates: widget.selectedDates,
              initialMonth: widget.initialMonth,
              minYears: minYears,
              onTap: (date) {
                widget.onChanged(date);
              },
            ),
            itemCount: math.max(_itemCount, minYears),
            padding: const EdgeInsets.symmetric(horizontal: yearPickerPadding),
          ),
        ),
        Divider(
          color: widget.config.hideYearPickerDividers == true
              ? Colors.transparent
              : null,
        ),
      ],
    );
  }
}
