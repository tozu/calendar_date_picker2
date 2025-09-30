import 'package:calendar_date_picker2/src/models/models.dart';
import 'package:flutter/material.dart';

import 'month_picker_constants.dart';
import 'month_picker_grid_delegate.dart';
import 'month_picker_item.dart';

/// A scrollable grid of months to allow picking a month.
///
/// The month picker widget is rarely used directly. Instead, consider using [CalendarDatePicker2]
///
/// See also:
///
///  * [CalendarDatePicker2], which provides a Material Design date picker
///    interface.
///
///
class MonthPicker extends StatefulWidget {
  /// Creates a month picker.
  const MonthPicker({
    required this.config,
    required this.selectedDates,
    required this.onChanged,
    required this.initialMonth,
    Key? key,
  }) : super(key: key);

  /// The calendar configurations
  final CalendarDatePicker2Config config;

  /// The currently selected dates.
  ///
  /// Selected dates are highlighted in the picker.
  final List<DateTime?> selectedDates;

  /// Called when the user picks a month.
  final ValueChanged<DateTime> onChanged;

  /// The initial month to display.
  final DateTime initialMonth;

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final scrollOffset =
        widget.selectedDates.isNotEmpty && widget.selectedDates[0] != null
            ? _scrollOffsetForMonth(widget.selectedDates[0]!)
            : _scrollOffsetForMonth(DateUtils.dateOnly(DateTime.now()));
    _scrollController = widget.config.monthViewController ??
        ScrollController(initialScrollOffset: scrollOffset);
  }

  @override
  void didUpdateWidget(MonthPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDates != oldWidget.selectedDates) {
      final scrollOffset =
          widget.selectedDates.isNotEmpty && widget.selectedDates[0] != null
              ? _scrollOffsetForMonth(widget.selectedDates[0]!)
              : _scrollOffsetForMonth(DateUtils.dateOnly(DateTime.now()));
      _scrollController.jumpTo(scrollOffset);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert(debugCheckHasMaterialLocalizations(context));
  }

  double _scrollOffsetForMonth(DateTime date) {
    final int initialMonthIndex = date.month - DateTime.january;
    final int initialMonthRow = initialMonthIndex ~/ monthPickerColumnCount;
    final int centeredMonthRow = initialMonthRow - 2;
    return centeredMonthRow * monthPickerRowHeight;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return Column(
      children: <Widget>[
        Divider(
          color: widget.config.hideMonthPickerDividers == true
              ? Colors.transparent
              : null,
        ),
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            gridDelegate: const MonthPickerGridDelegate(),
            itemBuilder: (context, index) {
              return MonthPickerItem(
                index,
                config: widget.config,
                selectedDates: widget.selectedDates,
                initialMonth: widget.initialMonth,
                onTap: (date) {
                  widget.onChanged(date);
                },
              );
            },
            itemCount: 12,
            padding: const EdgeInsets.symmetric(horizontal: monthPickerPadding),
          ),
        ),
        Divider(
          color: widget.config.hideMonthPickerDividers == true
              ? Colors.transparent
              : null,
        ),
      ],
    );
  }
}
