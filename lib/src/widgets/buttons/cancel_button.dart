// import 'package:calendar_date_picker2/src/models/models.dart';
// import 'package:flutter/material.dart';

part of '../calendar_date_picker2_with_action_buttons.dart';

class _CancelButton extends StatelessWidget {
  final CalendarDatePicker2WithActionButtonsConfig config;
  final VoidCallback? onTap;

  const _CancelButton({
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
        child: config.cancelButton ??
            Text(
              localizations.cancelButtonLabel.toUpperCase(),
              style: config.cancelButtonTextStyle ??
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
