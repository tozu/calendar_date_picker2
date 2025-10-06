part of '../calendar_date_picker2.dart';

T? _ambiguate<T>(T? value) => value;

class _CalendarView extends StatefulWidget {
  /// Creates a month picker.
  const _CalendarView({
    required this.config,
    required this.initialMonth,
    required this.selectedDates,
    required this.onChanged,
    required this.onDisplayedMonthChanged,
    Key? key,
  }) : super(key: key);

  /// The calendar configurations
  final CalendarDatePicker2Config config;

  /// The initial month to display.
  final DateTime initialMonth;

  /// The currently selected dates.
  ///
  /// Selected dates are highlighted in the picker.
  final List<DateTime?> selectedDates;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// Called when the user navigates to a new month.
  final ValueChanged<DateTime> onDisplayedMonthChanged;

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView>
    with CalendarViewNavigationMixin {
  final GlobalKey _pageViewKey = GlobalKey();
  late DateTime _currentMonth;
  late PageController _pageController;
  late MaterialLocalizations _localizations;
  late TextDirection _textDirection;

  DateTime? _focusedDay;

  late FocusNode _dayGridFocus;

  @override
  FocusNode get dayGridFocus => _dayGridFocus;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialMonth;
    _pageController = widget.config.dayViewController ??
        PageController(
          initialPage:
              DateUtils.monthDelta(widget.config.firstDate, _currentMonth),
        );

    _dayGridFocus = FocusNode(debugLabel: 'Day Grid');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = MaterialLocalizations.of(context);
    _textDirection = Directionality.of(context);
  }

  @override
  void didUpdateWidget(_CalendarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialMonth != oldWidget.initialMonth &&
        widget.initialMonth != _currentMonth) {
      // We can't interrupt this widget build with a scroll, so do it next frame
      // Add workaround to fix Flutter 3.0.0 compiler issue
      // https://github.com/flutter/flutter/issues/103561#issuecomment-1125512962
      // https://github.com/flutter/website/blob/3e6d87f13ad2a8dd9cf16081868cc3b3794abb90/src/development/tools/sdk/release-notes/release-notes-3.0.0.md#your-code
      _ambiguate(WidgetsBinding.instance)!.addPostFrameCallback(
        (Duration timeStamp) => _showMonth(widget.initialMonth,
            jump: widget.config.animateToDisplayedMonthDate != true),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _dayGridFocus.dispose();
    super.dispose();
  }

  void _handleDateSelected(DateTime selectedDate) {
    _focusedDay = selectedDate;
    widget.onChanged(selectedDate);
  }

  void _handleMonthPageChanged(int monthPage) {
    setState(() {
      final DateTime monthDate =
          DateUtils.addMonthsToMonthDate(widget.config.firstDate, monthPage);
      if (!DateUtils.isSameMonth(_currentMonth, monthDate)) {
        _currentMonth = DateTime(monthDate.year, monthDate.month);
        widget.onDisplayedMonthChanged(_currentMonth);
        if (_focusedDay != null &&
            !DateUtils.isSameMonth(_focusedDay, _currentMonth)) {
          // We have navigated to a new month with the grid focused, but the
          // focused day is not in this month. Choose a new one trying to keep
          // the same day of the month.
          _focusedDay = _focusableDayForMonth(_currentMonth, _focusedDay!.day);
        }
        SemanticsService.announce(
          _localizations.formatMonthYear(_currentMonth),
          _textDirection,
        );
      }
    });
  }

  /// Returns a focusable date for the given month.
  ///
  /// If the preferredDay is available in the month it will be returned,
  /// otherwise the first selectable day in the month will be returned. If
  /// no dates are selectable in the month, then it will return null.
  DateTime? _focusableDayForMonth(DateTime month, int preferredDay) {
    final int daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);

    // Can we use the preferred day in this month?
    if (preferredDay <= daysInMonth) {
      final DateTime newFocus = DateTime(month.year, month.month, preferredDay);
      if (_isSelectable(newFocus)) return newFocus;
    }

    // Start at the 1st and take the first selectable date.
    for (int day = 1; day <= daysInMonth; day++) {
      final DateTime newFocus = DateTime(month.year, month.month, day);
      if (_isSelectable(newFocus)) return newFocus;
    }
    return null;
  }

  /// Navigate to the next month.
  void _handleNextMonth() {
    if (!_isDisplayingLastMonth) {
      _pageController.nextPage(
        duration: _monthScrollDuration,
        curve: Curves.ease,
      );
    }
  }

  /// Navigate to the previous month.
  void _handlePreviousMonth() {
    if (!_isDisplayingFirstMonth) {
      _pageController.previousPage(
        duration: _monthScrollDuration,
        curve: Curves.ease,
      );
    }
  }

  /// Navigate to the given month.
  void _showMonth(DateTime month, {bool jump = false}) {
    final int monthPage = DateUtils.monthDelta(widget.config.firstDate, month);
    if (jump) {
      _pageController.jumpToPage(monthPage);
    } else {
      _pageController.animateToPage(
        monthPage,
        duration: _monthScrollDuration,
        curve: Curves.ease,
      );
    }
  }

  /// True if the earliest allowable month is displayed.
  bool get _isDisplayingFirstMonth {
    return !_currentMonth.isAfter(
      DateTime(widget.config.firstDate.year, widget.config.firstDate.month),
    );
  }

  /// True if the latest allowable month is displayed.
  bool get _isDisplayingLastMonth {
    return !_currentMonth.isBefore(
      DateTime(widget.config.lastDate.year, widget.config.lastDate.month),
    );
  }

  /// Handler for when the overall day grid obtains or loses focus.
  void _handleGridFocusChange(bool focused) {
    setState(() {
      if (focused && _focusedDay == null && widget.selectedDates.isNotEmpty) {
        if (DateUtils.isSameMonth(widget.selectedDates[0], _currentMonth)) {
          _focusedDay = widget.selectedDates[0];
        } else if (DateUtils.isSameMonth(
            widget.config.currentDate, _currentMonth)) {
          _focusedDay = _focusableDayForMonth(
              _currentMonth, widget.config.currentDate.day);
        } else {
          _focusedDay = _focusableDayForMonth(_currentMonth, 1);
        }
      }
    });
  }

  /// Move the internal focus date in the direction of the given intent.
  ///
  /// This will attempt to move the focused day to the next selectable day in
  /// the given direction. If the new date is not in the current month, then
  /// the page view will be scrolled to show the new date's month.
  ///
  /// For horizontal directions, it will move forward or backward a day (depending
  /// on the current [TextDirection]). For vertical directions it will move up and
  /// down a week at a time.
  @override
  void handleDirectionFocus(DirectionalFocusIntent intent) {
    setState(() {
      if (_focusedDay != null) {
        final nextDate = _nextDateInDirection(_focusedDay!, intent.direction);
        if (nextDate != null) {
          _focusedDay = nextDate;
          if (!DateUtils.isSameMonth(_focusedDay, _currentMonth)) {
            _showMonth(_focusedDay!);
          }
        }
      } else {
        _focusedDay ??= widget.initialMonth;
      }
    });
  }

  DateTime? _nextDateInDirection(DateTime date, TraversalDirection direction) {
    final TextDirection textDirection = Directionality.of(context);
    DateTime nextDate = DateUtils.addDaysToDate(
        date, dayDirectionOffset(direction, textDirection));
    while (!nextDate.isBefore(widget.config.firstDate) &&
        !nextDate.isAfter(widget.config.lastDate)) {
      if (_isSelectable(nextDate)) {
        return nextDate;
      }
      nextDate = DateUtils.addDaysToDate(
          nextDate, dayDirectionOffset(direction, textDirection));
    }
    return null;
  }

  bool _isSelectable(DateTime date) {
    return widget.config.selectableDayPredicate?.call(date) ?? true;
  }

  Widget _buildItems(BuildContext context, int index) {
    final DateTime month =
        DateUtils.addMonthsToMonthDate(widget.config.firstDate, index);
    return _DayPicker(
      key: ValueKey<DateTime>(month),
      selectedDates: widget.selectedDates.whereType<DateTime>().toList(),
      onChanged: _handleDateSelected,
      config: widget.config,
      displayedMonth: month,
      dayRowsCount: widget.config.dynamicCalendarRows == true
          ? getDayRowsCount(
              month.year,
              month.month,
              widget.config.firstDayOfWeek ??
                  _localizations.firstDayOfWeekIndex,
            )
          : _maxDayPickerRowCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      child: Column(
        children: <Widget>[
          Container(
            padding: widget.config.centerAlignModePicker != true
                ? const EdgeInsetsDirectional.only(start: 16, end: 4)
                : const EdgeInsetsDirectional.only(start: 8, end: 8),
            height: (widget.config.controlsHeight ?? _subHeaderHeight),
            child: Row(
              children: <Widget>[
                if (widget.config.centerAlignModePicker != true) const Spacer(),
                if (widget.config.hideLastMonthIcon != true)
                  widget.config.monthControlBuilder?.call(
                        onPressed: _handlePreviousMonth,
                        isInactive: _isDisplayingFirstMonth,
                        icon: widget.config.dayModeScrollDirection ==
                                Axis.vertical
                            ? Icons.keyboard_arrow_up
                            : Icons.chevron_left,
                        tooltip: _localizations.previousMonthTooltip,
                      ) ??
                      _MonthControlButton(
                        focusNode: FocusNode(debugLabel: 'Previous month'),
                        config: widget.config,
                        verticalIcon: Icons.keyboard_arrow_up,
                        horizontalIcon: Icons.chevron_left,
                    tooltip: _isDisplayingFirstMonth
                        ? null
                        : _localizations.previousMonthTooltip,
                        onPressed: _isDisplayingFirstMonth
                            ? null
                            : _handlePreviousMonth,
                  ),
                if (widget.config.centerAlignModePicker == true) const Spacer(),
                if (widget.config.hideNextMonthIcon != true)
                  widget.config.monthControlBuilder?.call(
                        onPressed: _handleNextMonth,
                        isInactive: _isDisplayingLastMonth,
                        icon: widget.config.dayModeScrollDirection ==
                                Axis.vertical
                            ? Icons.keyboard_arrow_down
                            : Icons.chevron_right,
                        tooltip: _localizations.nextMonthTooltip,
                      ) ??
                      _MonthControlButton(
                        focusNode: FocusNode(debugLabel: 'Next month'),
                        config: widget.config,
                        verticalIcon: Icons.keyboard_arrow_down,
                        horizontalIcon: Icons.chevron_right,
                    tooltip: _isDisplayingLastMonth
                        ? null
                        : _localizations.nextMonthTooltip,
                        onPressed:
                            _isDisplayingLastMonth ? null : _handleNextMonth,
                  ),
              ],
            ),
          ),
          Expanded(
            child: FocusableActionDetector(
              shortcuts: shortcuts,
              actions: actions,
              focusNode: _dayGridFocus,
              onFocusChange: _handleGridFocusChange,
              child: _FocusedDate(
                date: _dayGridFocus.hasFocus ? _focusedDay : null,
                child: PageView.builder(
                  key: _pageViewKey,
                  physics: widget.config.calendarViewScrollPhysics,
                  controller: _pageController,
                  itemBuilder: _buildItems,
                  itemCount: DateUtils.monthDelta(
                          widget.config.firstDate, widget.config.lastDate) +
                      1,
                  onPageChanged: _handleMonthPageChanged,
                  scrollDirection:
                      widget.config.dayModeScrollDirection ?? Axis.horizontal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
