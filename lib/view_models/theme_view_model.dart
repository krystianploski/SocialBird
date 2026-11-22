import 'package:flutter/foundation.dart';

class ThemeViewModel extends ChangeNotifier {
  bool isDarkMode = true;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
