import 'package:shared_preferences/shared_preferences.dart';

abstract class WelcomeLocalDataSource {
  Future<bool> isWelcomeCompleted();
  Future<void> completeWelcome();
}

class WelcomeLocalDataSourceImpl implements WelcomeLocalDataSource {
  static const String _welcomeCompletedKey = 'welcomeCompleted';

  final SharedPreferences sharedPreferences;

  WelcomeLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<bool> isWelcomeCompleted() async {
    return sharedPreferences.getBool(_welcomeCompletedKey) ?? false;
  }

  @override
  Future<void> completeWelcome() async {
    await sharedPreferences.setBool(_welcomeCompletedKey, true);
  }
}
