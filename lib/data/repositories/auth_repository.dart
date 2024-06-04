import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_to_do/data/models/user.dart';

const String _userKey = 'user';

class AuthRepository {
  const AuthRepository({required this.sp});

  final SharedPreferences sp;

  Future<User?> getUser() async {
    final userData = sp.getString(_userKey);
    if (userData == null) {
      return null;
    }
    final userDataDecode = jsonDecode(userData);
    final user = User.fromMap(userDataDecode);
    return user;
  }

  Future<void> saveUser(User user) async {
    final userEncode = jsonEncode(user.toMap());
    await sp.setString(_userKey, userEncode);
  }

  Future<void> deleteUser() async => await sp.remove(_userKey);
}
