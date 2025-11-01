import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String ideasKey = "ideas";
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static List<String> loadIdeas() {
    return _prefs?.getStringList(ideasKey) ?? [];
  }

  static Future<void> saveIdeas(List<String> ideas) async {
    await _prefs?.setStringList(ideasKey, ideas);
  }
}
