import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/src/models/models.dart';

/// Custom configuration for CalendarDatePicker2 with action buttons
class CalendarDatePicker2WithActionButtonsConfig
    extends CalendarDatePicker2Config {
  CalendarDatePicker2WithActionButtonsConfig({
    CalendarDatePicker2Type? calendarType,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
    CalendarDatePicker2Mode? calendarViewMode,
    List<String>? weekdayLabels,
    TextStyle? weekdayLabelTextStyle,
    WeekdayLabelBuilder? weekdayLabelBuilder,
    int? firstDayOfWeek,
    double? controlsHeight,
    Widget? lastMonthIcon,
    bool? hideLastMonthIcon,
    Widget? nextMonthIcon,
    bool? hideNextMonthIcon,
    TextStyle? controlsTextStyle,
    bool? animateToDisplayedMonthDate,
    Map<CalendarDatePicker2SemanticsLabel, String?>? semanticsDictionary,
    bool? disableVibration,
    PageController? dayViewController,
    TextStyle? dayTextStyle,
    TextStyle? selectedDayTextStyle,
    Color? selectedDayHighlightColor,
    Color? selectedRangeHighlightColor,
    TextStyle? disabledDayTextStyle,
    TextStyle? todayTextStyle,
    TextStyle? yearTextStyle,
    TextStyle? selectedYearTextStyle,
    TextStyle? disabledYearTextStyle,
    TextStyle? selectedRangeDayTextStyle,
    TextStyle? monthTextStyle,
    TextStyle? selectedMonthTextStyle,
    TextStyle? disabledMonthTextStyle,
    BorderRadius? dayBorderRadius,
    BorderRadius? yearBorderRadius,
    BorderRadius? monthBorderRadius,
    SelectableDayPredicate? selectableDayPredicate,
    SelectableMonthPredicate? selectableMonthPredicate,
    SelectableYearPredicate? selectableYearPredicate,
    DayTextStylePredicate? dayTextStylePredicate,
    DayBuilder? dayBuilder,
    YearBuilder? yearBuilder,
    MonthBuilder? monthBuilder,
    ScrollController? monthViewController,
    ScrollController? yearViewController,
    bool? disableModePicker,
    bool? centerAlignModePicker,
    Widget? customModePickerIcon,
    ModePickerTextHandler? modePickerTextHandler,
    ModePickerBuilder? modePickerBuilder,
    double? modePickersGap,
    bool? rangeBidirectional,
    ScrollPhysics? calendarViewScrollPhysics,
    Color? daySplashColor,
    bool? allowSameValueSelection,
    bool? disableMonthPicker,
    bool? useAbbrLabelForMonthModePicker,
    double? dayMaxWidth,
    bool? hideMonthPickerDividers,
    bool? hideYearPickerDividers,
    TextStyle? scrollViewTopHeaderTextStyle,
    bool? hideScrollViewTopHeader,
    bool? hideScrollViewTopHeaderDivider,
    bool? hideScrollViewMonthWeekHeader,
    BoxConstraints? scrollViewConstraints,
    ScrollViewMonthYearBuilder? scrollViewMonthYearBuilder,
    ScrollViewOnScrolling? scrollViewOnScrolling,
    ScrollController? scrollViewController,
    bool? dynamicCalendarRows,
    Axis? dayModeScrollDirection,
    SelectedRangeHighlightBuilder? selectedRangeHighlightBuilder,
    SelectedRangeDecorationPredicate? selectedRangeDecorationPredicate,
    this.gapBetweenCalendarAndButtons,
    this.cancelButtonTextStyle,
    this.cancelButton,
    this.okButtonTextStyle,
    this.okButton,
    this.openedFromDialog,
    this.closeDialogOnCancelTapped,
    this.closeDialogOnOkTapped,
    this.buttonPadding,
  }) : super(
          calendarType: calendarType,
          firstDate: firstDate,
          lastDate: lastDate,
          currentDate: currentDate,
          calendarViewMode: calendarViewMode,
          weekdayLabels: weekdayLabels,
          weekdayLabelTextStyle: weekdayLabelTextStyle,
          weekdayLabelBuilder: weekdayLabelBuilder,
          firstDayOfWeek: firstDayOfWeek,
          controlsHeight: controlsHeight,
          lastMonthIcon: lastMonthIcon,
          hideLastMonthIcon: hideLastMonthIcon,
          nextMonthIcon: nextMonthIcon,
          hideNextMonthIcon: hideNextMonthIcon,
          controlsTextStyle: controlsTextStyle,
          animateToDisplayedMonthDate: animateToDisplayedMonthDate,
          semanticsDictionary: semanticsDictionary,
          disableVibration: disableVibration,
          dayViewController: dayViewController,
          dayTextStyle: dayTextStyle,
          selectedDayTextStyle: selectedDayTextStyle,
          selectedRangeDayTextStyle: selectedRangeDayTextStyle,
          selectedDayHighlightColor: selectedDayHighlightColor,
          selectedRangeHighlightColor: selectedRangeHighlightColor,
          disabledDayTextStyle: disabledDayTextStyle,
          todayTextStyle: todayTextStyle,
          yearTextStyle: yearTextStyle,
          selectedYearTextStyle: selectedYearTextStyle,
          disabledYearTextStyle: disabledYearTextStyle,
          monthTextStyle: monthTextStyle,
          selectedMonthTextStyle: selectedMonthTextStyle,
          disabledMonthTextStyle: disabledMonthTextStyle,
          dayBorderRadius: dayBorderRadius,
          yearBorderRadius: yearBorderRadius,
          monthBorderRadius: monthBorderRadius,
          selectableDayPredicate: selectableDayPredicate,
          selectableMonthPredicate: selectableMonthPredicate,
          selectableYearPredicate: selectableYearPredicate,
          dayTextStylePredicate: dayTextStylePredicate,
          dayBuilder: dayBuilder,
          yearBuilder: yearBuilder,
          monthBuilder: monthBuilder,
          monthViewController: monthViewController,
          yearViewController: yearViewController,
          disableModePicker: disableModePicker,
          centerAlignModePicker: centerAlignModePicker,
          customModePickerIcon: customModePickerIcon,
          modePickerTextHandler: modePickerTextHandler,
          modePickerBuilder: modePickerBuilder,
          modePickersGap: modePickersGap,
          rangeBidirectional: rangeBidirectional,
          calendarViewScrollPhysics: calendarViewScrollPhysics,
          daySplashColor: daySplashColor,
          allowSameValueSelection: allowSameValueSelection,
          disableMonthPicker: disableMonthPicker,
          useAbbrLabelForMonthModePicker: useAbbrLabelForMonthModePicker,
          dayMaxWidth: dayMaxWidth,
          hideMonthPickerDividers: hideMonthPickerDividers,
          hideYearPickerDividers: hideYearPickerDividers,
          scrollViewTopHeaderTextStyle: scrollViewTopHeaderTextStyle,
          hideScrollViewTopHeader: hideScrollViewTopHeader,
          hideScrollViewTopHeaderDivider: hideScrollViewTopHeaderDivider,
          hideScrollViewMonthWeekHeader: hideScrollViewMonthWeekHeader,
          scrollViewConstraints: scrollViewConstraints,
          scrollViewMonthYearBuilder: scrollViewMonthYearBuilder,
          scrollViewOnScrolling: scrollViewOnScrolling,
          scrollViewController: scrollViewController,
          dynamicCalendarRows: dynamicCalendarRows,
          dayModeScrollDirection: dayModeScrollDirection,
          selectedRangeHighlightBuilder: selectedRangeHighlightBuilder,
          selectedRangeDecorationPredicate: selectedRangeDecorationPredicate,
        );

  /// The gap between calendar and action buttons
  final double? gapBetweenCalendarAndButtons;

  /// Text style for cancel button
  final TextStyle? cancelButtonTextStyle;

  /// Custom cancel button
  final Widget? cancelButton;

  /// Text style for ok button
  final TextStyle? okButtonTextStyle;

  /// Custom ok button
  final Widget? okButton;

  /// Is the calendar opened from dialog
  final bool? openedFromDialog;

  /// If the dialog should be closed when user taps the CANCEL button
  final bool? closeDialogOnCancelTapped;

  /// If the dialog should be closed when user taps the OK button
  final bool? closeDialogOnOkTapped;

  /// Custom wrapping padding for Ok & Cancel buttons
  final EdgeInsets? buttonPadding;

  @override
  CalendarDatePicker2WithActionButtonsConfig copyWith({
    CalendarDatePicker2Type? calendarType,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
    CalendarDatePicker2Mode? calendarViewMode,
    List<String>? weekdayLabels,
    TextStyle? weekdayLabelTextStyle,
    WeekdayLabelBuilder? weekdayLabelBuilder,
    int? firstDayOfWeek,
    double? controlsHeight,
    Widget? lastMonthIcon,
    bool? hideLastMonthIcon,
    Widget? nextMonthIcon,
    bool? hideNextMonthIcon,
    TextStyle? controlsTextStyle,
    bool? animateToDisplayedMonthDate,
    Map<CalendarDatePicker2SemanticsLabel, String?>? semanticsDictionary,
    bool? disableVibration,
    PageController? dayViewController,
    TextStyle? dayTextStyle,
    TextStyle? selectedDayTextStyle,
    TextStyle? selectedRangeDayTextStyle,
    Color? selectedDayHighlightColor,
    Color? selectedRangeHighlightColor,
    TextStyle? disabledDayTextStyle,
    TextStyle? todayTextStyle,
    TextStyle? yearTextStyle,
    TextStyle? selectedYearTextStyle,
    TextStyle? disabledYearTextStyle,
    TextStyle? monthTextStyle,
    TextStyle? selectedMonthTextStyle,
    TextStyle? disabledMonthTextStyle,
    BorderRadius? dayBorderRadius,
    BorderRadius? yearBorderRadius,
    BorderRadius? monthBorderRadius,
    SelectableDayPredicate? selectableDayPredicate,
    SelectableMonthPredicate? selectableMonthPredicate,
    SelectableYearPredicate? selectableYearPredicate,
    DayTextStylePredicate? dayTextStylePredicate,
    DayBuilder? dayBuilder,
    YearBuilder? yearBuilder,
    MonthBuilder? monthBuilder,
    ScrollController? monthViewController,
    ScrollController? yearViewController,
    bool? disableModePicker,
    bool? centerAlignModePicker,
    Widget? customModePickerIcon,
    ModePickerTextHandler? modePickerTextHandler,
    ModePickerBuilder? modePickerBuilder,
    double? modePickersGap,
    double? gapBetweenCalendarAndButtons,
    TextStyle? cancelButtonTextStyle,
    Widget? cancelButton,
    TextStyle? okButtonTextStyle,
    Widget? okButton,
    bool? openedFromDialog,
    bool? closeDialogOnCancelTapped,
    bool? closeDialogOnOkTapped,
    EdgeInsets? buttonPadding,
    bool? rangeBidirectional,
    ScrollPhysics? calendarViewScrollPhysics,
    Color? daySplashColor,
    bool? allowSameValueSelection,
    bool? disableMonthPicker,
    bool? useAbbrLabelForMonthModePicker,
    double? dayMaxWidth,
    bool? hideMonthPickerDividers,
    bool? hideYearPickerDividers,
    TextStyle? scrollViewTopHeaderTextStyle,
    bool? hideScrollViewTopHeader,
    bool? hideScrollViewTopHeaderDivider,
    bool? hideScrollViewMonthWeekHeader,
    BoxConstraints? scrollViewConstraints,
    ScrollViewMonthYearBuilder? scrollViewMonthYearBuilder,
    ScrollViewOnScrolling? scrollViewOnScrolling,
    ScrollController? scrollViewController,
    bool? dynamicCalendarRows,
    Axis? dayModeScrollDirection,
    SelectedRangeHighlightBuilder? selectedRangeHighlightBuilder,
    SelectedRangeDecorationPredicate? selectedRangeDecorationPredicate,
  }) {
    return CalendarDatePicker2WithActionButtonsConfig(
      calendarType: calendarType ?? this.calendarType,
      firstDate: DateUtils.dateOnly(firstDate ?? this.firstDate),
      lastDate: DateUtils.dateOnly(lastDate ?? this.lastDate),
      currentDate: currentDate ?? this.currentDate,
      calendarViewMode: calendarViewMode ?? this.calendarViewMode,
      weekdayLabels: weekdayLabels ?? this.weekdayLabels,
      weekdayLabelTextStyle:
          weekdayLabelTextStyle ?? this.weekdayLabelTextStyle,
      weekdayLabelBuilder: weekdayLabelBuilder ?? this.weekdayLabelBuilder,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      controlsHeight: controlsHeight ?? this.controlsHeight,
      lastMonthIcon: lastMonthIcon ?? this.lastMonthIcon,
      hideLastMonthIcon: hideLastMonthIcon ?? this.hideLastMonthIcon,
      nextMonthIcon: nextMonthIcon ?? this.nextMonthIcon,
      hideNextMonthIcon: hideNextMonthIcon ?? this.hideNextMonthIcon,
      controlsTextStyle: controlsTextStyle ?? this.controlsTextStyle,
      animateToDisplayedMonthDate:
          animateToDisplayedMonthDate ?? this.animateToDisplayedMonthDate,
      semanticsDictionary: semanticsDictionary ?? this.semanticsDictionary,
      disableVibration: disableVibration ?? this.disableVibration,
      dayViewController: dayViewController ?? this.dayViewController,
      dayTextStyle: dayTextStyle ?? this.dayTextStyle,
      selectedDayTextStyle: selectedDayTextStyle ?? this.selectedDayTextStyle,
      selectedRangeDayTextStyle:
          selectedRangeDayTextStyle ?? this.selectedRangeDayTextStyle,
      selectedDayHighlightColor:
          selectedDayHighlightColor ?? this.selectedDayHighlightColor,
      selectedRangeHighlightColor:
          selectedRangeHighlightColor ?? this.selectedRangeHighlightColor,
      disabledDayTextStyle: disabledDayTextStyle ?? this.disabledDayTextStyle,
      todayTextStyle: todayTextStyle ?? this.todayTextStyle,
      yearTextStyle: yearTextStyle ?? this.yearTextStyle,
      selectedYearTextStyle:
          selectedYearTextStyle ?? this.selectedYearTextStyle,
      disabledYearTextStyle:
          disabledYearTextStyle ?? this.disabledYearTextStyle,
      monthTextStyle: monthTextStyle ?? this.monthTextStyle,
      selectedMonthTextStyle:
          selectedMonthTextStyle ?? this.selectedMonthTextStyle,
      disabledMonthTextStyle:
          disabledMonthTextStyle ?? this.disabledMonthTextStyle,
      dayBorderRadius: dayBorderRadius ?? this.dayBorderRadius,
      yearBorderRadius: yearBorderRadius ?? this.yearBorderRadius,
      monthBorderRadius: monthBorderRadius ?? this.monthBorderRadius,
      selectableDayPredicate:
          selectableDayPredicate ?? this.selectableDayPredicate,
      selectableMonthPredicate:
          selectableMonthPredicate ?? this.selectableMonthPredicate,
      selectableYearPredicate:
          selectableYearPredicate ?? this.selectableYearPredicate,
      dayTextStylePredicate:
          dayTextStylePredicate ?? this.dayTextStylePredicate,
      dayBuilder: dayBuilder ?? this.dayBuilder,
      yearBuilder: yearBuilder ?? this.yearBuilder,
      monthBuilder: monthBuilder ?? this.monthBuilder,
      monthViewController: monthViewController ?? this.monthViewController,
      yearViewController: yearViewController ?? this.yearViewController,
      disableModePicker: disableModePicker ?? this.disableModePicker,
      centerAlignModePicker:
          centerAlignModePicker ?? this.centerAlignModePicker,
      customModePickerIcon: customModePickerIcon ?? this.customModePickerIcon,
      modePickerTextHandler:
          modePickerTextHandler ?? this.modePickerTextHandler,
      modePickerBuilder: modePickerBuilder ?? this.modePickerBuilder,
      modePickersGap: modePickersGap ?? this.modePickersGap,
      rangeBidirectional: rangeBidirectional ?? this.rangeBidirectional,
      gapBetweenCalendarAndButtons:
          gapBetweenCalendarAndButtons ?? this.gapBetweenCalendarAndButtons,
      cancelButtonTextStyle:
          cancelButtonTextStyle ?? this.cancelButtonTextStyle,
      cancelButton: cancelButton ?? this.cancelButton,
      okButtonTextStyle: okButtonTextStyle ?? this.okButtonTextStyle,
      okButton: okButton ?? this.okButton,
      openedFromDialog: openedFromDialog ?? this.openedFromDialog,
      closeDialogOnCancelTapped:
          closeDialogOnCancelTapped ?? this.closeDialogOnCancelTapped,
      closeDialogOnOkTapped:
          closeDialogOnOkTapped ?? this.closeDialogOnOkTapped,
      buttonPadding: buttonPadding ?? this.buttonPadding,
      calendarViewScrollPhysics:
          calendarViewScrollPhysics ?? this.calendarViewScrollPhysics,
      daySplashColor: daySplashColor ?? this.daySplashColor,
      allowSameValueSelection:
          allowSameValueSelection ?? this.allowSameValueSelection,
      disableMonthPicker: disableMonthPicker ?? this.disableMonthPicker,
      useAbbrLabelForMonthModePicker:
          useAbbrLabelForMonthModePicker ?? this.useAbbrLabelForMonthModePicker,
      dayMaxWidth: dayMaxWidth ?? this.dayMaxWidth,
      hideMonthPickerDividers:
          hideMonthPickerDividers ?? this.hideMonthPickerDividers,
      hideYearPickerDividers:
          hideYearPickerDividers ?? this.hideYearPickerDividers,
      scrollViewTopHeaderTextStyle:
          scrollViewTopHeaderTextStyle ?? this.scrollViewTopHeaderTextStyle,
      hideScrollViewTopHeader:
          hideScrollViewTopHeader ?? this.hideScrollViewTopHeader,
      hideScrollViewTopHeaderDivider:
          hideScrollViewTopHeaderDivider ?? this.hideScrollViewTopHeaderDivider,
      hideScrollViewMonthWeekHeader:
          hideScrollViewMonthWeekHeader ?? this.hideScrollViewMonthWeekHeader,
      scrollViewConstraints:
          scrollViewConstraints ?? this.scrollViewConstraints,
      scrollViewMonthYearBuilder:
          scrollViewMonthYearBuilder ?? this.scrollViewMonthYearBuilder,
      scrollViewOnScrolling:
          scrollViewOnScrolling ?? this.scrollViewOnScrolling,
      scrollViewController: scrollViewController ?? this.scrollViewController,
      dynamicCalendarRows: dynamicCalendarRows ?? this.dynamicCalendarRows,
      dayModeScrollDirection:
          dayModeScrollDirection ?? this.dayModeScrollDirection,
      selectedRangeHighlightBuilder:
          selectedRangeHighlightBuilder ?? this.selectedRangeHighlightBuilder,
      selectedRangeDecorationPredicate: selectedRangeDecorationPredicate ??
          this.selectedRangeDecorationPredicate,
    );
  }
}
