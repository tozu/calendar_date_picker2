import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

mixin CalendarViewNavigationMixin<T extends StatefulWidget> on State<T> {
  FocusNode get dayGridFocus;

  /// Move focus to the next element after the day grid.
  void handleGridNextFocus(NextFocusIntent intent) {
    dayGridFocus.requestFocus();
    dayGridFocus.nextFocus();
  }

  /// Move focus to the previous element before the day grid.
  void handleGridPreviousFocus(PreviousFocusIntent intent) {
    dayGridFocus.requestFocus();
    dayGridFocus.previousFocus();
  }

  void handleDirectionFocus(DirectionalFocusIntent intent);

  Map<Type, Action<Intent>> get actions => <Type, Action<Intent>>{
        NextFocusIntent: CallbackAction<NextFocusIntent>(
          onInvoke: handleGridNextFocus,
        ),
        PreviousFocusIntent: CallbackAction<PreviousFocusIntent>(
          onInvoke: handleGridPreviousFocus,
        ),
        DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(
          onInvoke: handleDirectionFocus,
        ),
      };

  Map<ShortcutActivator, Intent>? get shortcuts =>
      const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.arrowLeft):
            DirectionalFocusIntent(TraversalDirection.left),
        SingleActivator(LogicalKeyboardKey.arrowRight):
            DirectionalFocusIntent(TraversalDirection.right),
        SingleActivator(LogicalKeyboardKey.arrowDown):
            DirectionalFocusIntent(TraversalDirection.down),
        SingleActivator(LogicalKeyboardKey.arrowUp):
            DirectionalFocusIntent(TraversalDirection.up),
      };

  int dayDirectionOffset(
    TraversalDirection traversalDirection,
    TextDirection textDirection,
  ) {
    // Swap left and right if the text direction if RTL
    if (textDirection == TextDirection.rtl) {
      if (traversalDirection == TraversalDirection.left) {
        traversalDirection = TraversalDirection.right;
      } else if (traversalDirection == TraversalDirection.right) {
        traversalDirection = TraversalDirection.left;
      }
    }
    return _directionOffset[traversalDirection]!;
  }

  Map<TraversalDirection, int> get _directionOffset =>
      const <TraversalDirection, int>{
        TraversalDirection.up: -DateTime.daysPerWeek,
        TraversalDirection.right: 1,
        TraversalDirection.down: DateTime.daysPerWeek,
        TraversalDirection.left: -1,
      };
}
