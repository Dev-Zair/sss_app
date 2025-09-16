import '../domain/language.dart';
import '../domain/language_repository.dart';

class MemoryLanguageRepository implements LanguageRepository {
  String? _selectedCode;

  // Exactly three languages as per UI requirement.
  static const List<Language> _langs = [
    Language(code: 'ru', emoji: '🇷🇺', nativeName: 'Русский', translatedName: 'Russian'),
    Language(code: 'en', emoji: '🇺🇸', nativeName: 'English', translatedName: 'Английский'),
    Language(code: 'kk', emoji: '🇰🇿', nativeName: 'Қазақша', translatedName: 'Казахский'),
  ];

  @override
  List<Language> getAvailableLanguages() => _langs;

  @override
  String? getSelectedCode() => _selectedCode;

  @override
  void setSelectedCode(String code) {
    _selectedCode = code;
  }
}
