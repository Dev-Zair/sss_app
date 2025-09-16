import 'package:flutter/widgets.dart';

import 'language_controller.dart';

class LanguageScope extends InheritedNotifier<LanguageController> {
  const LanguageScope({
    super.key,
    required LanguageController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static LanguageController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LanguageScope>();
    assert(scope != null, 'LanguageScope not found in context');
    return scope!.notifier!;
  }
}

