part of '../calendar_date_picker2_with_action_buttons.dart';

class _OkButton extends StatelessWidget {
  final CalendarDatePicker2WithActionButtonsConfig config;
  final VoidCallback? onTap;

  const _OkButton({
    required this.config,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: config.okButton ??
            Text(
              localizations.okButtonLabel.toUpperCase(),
              style: config.okButtonTextStyle ??
                  TextStyle(
                    color:
                        config.selectedDayHighlightColor ?? colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
            ),
      ),
    );
  }
}
