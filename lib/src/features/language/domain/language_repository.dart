import 'language.dart';

abstract class LanguageRepository {
  List<Language> getAvailableLanguages();

  String? getSelectedCode();
  void setSelectedCode(String code);
}

