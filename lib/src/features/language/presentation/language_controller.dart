import 'package:flutter/foundation.dart';

import '../domain/language.dart';
import '../domain/language_repository.dart';

class LanguageController extends ChangeNotifier {
  LanguageController(this._repo) {
    _selectedCode = _repo.getSelectedCode();
  }

  final LanguageRepository _repo;
  String? _selectedCode;

  List<Language> get languages => _repo.getAvailableLanguages();
  String? get selectedCode => _selectedCode;

  void select(String code) {
    if (_selectedCode == code) return;
    _selectedCode = code;
    _repo.setSelectedCode(code);
    notifyListeners();
  }
}
