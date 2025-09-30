part of '../_impl/calendar/calendar_view_picker.dart';

class MonthControlButtons extends StatelessWidget {
  final CalendarDatePicker2Config config;

  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  final bool isFirstMonth;
  final bool isLastMonth;

  const MonthControlButtons({
    required this.config,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.isFirstMonth,
    required this.isLastMonth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    return Container(
      padding: config.centerAlignModePicker != true
          ? const EdgeInsetsDirectional.only(start: 16, end: 4)
          : const EdgeInsetsDirectional.only(start: 8, end: 8),
      height: (config.controlsHeight ?? defaultHeaderHeight),
      child: Row(
        children: <Widget>[
          if (config.centerAlignModePicker != true) const Spacer(),
          if (config.hideLastMonthIcon != true)
            MonthSelectionButton(
              config: config,
              tooltip: localizations.previousMonthTooltip,
              verticalIcon: Icons.keyboard_arrow_up,
              horizontalIcon: Icons.chevron_left,
              skipWhen: isFirstMonth,
              onPressed: onPreviousMonth,
            ),
          if (config.centerAlignModePicker == true) const Spacer(),
          if (config.hideNextMonthIcon != true)
            MonthSelectionButton(
              config: config,
              tooltip: localizations.nextMonthTooltip,
              verticalIcon: Icons.keyboard_arrow_down,
              horizontalIcon: Icons.chevron_right,
              skipWhen: isLastMonth,
              onPressed: onNextMonth,
            ),
        ],
      ),
    );
  }
}
