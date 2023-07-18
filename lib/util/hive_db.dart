import 'package:hive_flutter/hive_flutter.dart';

class HiveDB {
  static HiveDB? _current;
  static HiveDB get current {
    _current ??= HiveDB();
    return _current!;
  }

  String username = '';
  String password = '';

  final _userAuthStore = Hive.box('userAuthStore');

  void createInitialData() {
    username = '';
    password = '';
  }

  void loadData() {
    username = _userAuthStore.get('username');
    password = _userAuthStore.get('password');
  }

  void updateDataBase() {
    _userAuthStore.put('username', username);
    _userAuthStore.put('password', password);
  }

  void close() {
    _userAuthStore.close();
  }
}
