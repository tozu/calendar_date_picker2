part of '../calendar_date_picker2.dart';

class _MonthControlButton extends StatelessWidget {
  final CalendarDatePicker2Config config;

  final IconData verticalIcon;
  final IconData horizontalIcon;

  final String? tooltip;
  final VoidCallback? onPressed;

  final FocusNode? focusNode;

  const _MonthControlButton({
    required this.config,
    required this.verticalIcon,
    required this.horizontalIcon,
    this.onPressed,
    this.focusNode,
    this.tooltip,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color controlColor =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.60);

    return IconButton(
      focusNode: focusNode,
      icon: Icon(
        config.dayModeScrollDirection == Axis.vertical
            ? verticalIcon
            : horizontalIcon,
      ),
      splashRadius:
          config.dayMaxWidth != null ? config.dayMaxWidth! * 2 / 3 : null,
      color: controlColor,
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
