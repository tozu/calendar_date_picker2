part of '../_impl/calendar/calendar_view_picker.dart';

class MonthSelectionButton extends StatelessWidget {
  final CalendarDatePicker2Config config;

  final String tooltip;

  final bool skipWhen;

  final IconData verticalIcon;
  final IconData horizontalIcon;

  final VoidCallback onPressed;

  const MonthSelectionButton({
    required this.config,
    required this.tooltip,
    required this.verticalIcon,
    required this.horizontalIcon,
    required this.skipWhen,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color controlColor =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.60);

    final splashRadius =
        config.dayMaxWidth != null ? config.dayMaxWidth! * 2 / 3 : null;

    return IconButton(
      splashRadius: splashRadius,
      icon: config.lastMonthIcon ??
          Icon(
            config.dayModeScrollDirection == Axis.vertical
                ? verticalIcon
                : horizontalIcon,
          ),
      color: controlColor,
      tooltip: skipWhen ? null : tooltip,
      onPressed: skipWhen ? null : onPressed,
    );
  }
}
