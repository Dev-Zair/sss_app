import 'package:flutter/material.dart';
import 'package:sss_app/src/features/language/presentation/language_controller.dart';
import 'package:sss_app/src/features/language/presentation/language_scope.dart';
import 'package:sss_app/src/features/language/domain/language.dart';
import 'package:sss_app/screens/settings/widgets/language_card.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? _selectedCode;

  // НЕ late final — чтобы не падать при повторных вызовах didChangeDependencies
  LanguageController? _controller;
  List<Language> _languages = const [];

  bool _depsInited = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // получать зависимости здесь
    _controller ??= LanguageScope.of(context);
    _languages = _controller!.languages;

    // первичная инициализация выбранного кода
    if (!_depsInited) {
      _selectedCode = _controller!.selectedCode ?? _guessSystemCode();
      _depsInited = true;
    }
  }

  String _guessSystemCode() {
    final systemCode =
        (Localizations.maybeLocaleOf(context) ?? const Locale('ru'))
            .languageCode;
    final supported = _languages.map((e) => e.code).toSet();
    return supported.contains(systemCode) ? systemCode : 'ru';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = _selectedCode;
    final controller = _controller; // для краткости

    return Scaffold(
      appBar: AppBar(
        title: const Text('Язык'),
        actions: [
          TextButton(
            onPressed: (selected == null || controller == null)
                ? null
                : () {
                    controller.select(selected);
                    Navigator.pop(context, selected);
                  },
            child: const Text('Сохранить'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              'Выберите язык интерфейса',
              style: theme.textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                final lang = _languages[index];
                final isSelected = _selectedCode == lang.code;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: LanguageCard(
                    language: lang,
                    selected: isSelected,
                    onTap: () => setState(() => _selectedCode = lang.code),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: FilledButton(
                onPressed: (selected == null || controller == null)
                    ? null
                    : () {
                        controller.select(selected);
                        Navigator.pop(context, selected);
                      },
                child: const Text('Сохранить'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
