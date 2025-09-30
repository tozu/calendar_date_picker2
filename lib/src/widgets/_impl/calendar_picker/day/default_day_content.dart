import 'package:flutter/material.dart';

class DefaultDayContent extends StatelessWidget {
  final int day;
  final BoxDecoration? decoration;

  const DefaultDayContent({
    required this.day,
    this.decoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: decoration,
              child: Center(
                child: Text(
                  localizations.formatDecimal(day),
                  style: textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
