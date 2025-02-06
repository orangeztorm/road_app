import '../../app/locator.dart';
import 'authentication_local_storage_data_source.dart';

class SessionManager {
  SessionManager._internal();

  static final SessionManager instance = SessionManager._internal();

  factory SessionManager() => instance;

  static final AuthLocalStorageDataSource _authLocalStorageDataSource =
      getIt<AuthLocalStorageDataSource>();

  static final Map<String, dynamic> _loginData = {};

  String? _token;
  String? _refreshToken;

  Future<String?> get bearerToken async {
    return (await getSavedToken) ?? _token ?? _loginData['token'] ?? '';
  }

  Future<String?> get token async {
    return (await getSavedToken) ?? _token;
  }

  String? get getToken => _token;

  String? get getRefreshToken => _refreshToken;

  String get email => _loginData['data']['email'] ?? '';

  Future<void> setLoginData(Map<String, dynamic> data) async {
    _loginData.clear();
    _loginData.addAll(data);
    // await _authLocalStorageDataSource.saveToken(data['token']);
  }

  Future<void> setToken(String token) async {
    _token = token;
    await _authLocalStorageDataSource.saveToken(token);
  }

  Future<void> setRefreshToken(String token) async {
    _refreshToken = token;
    await _authLocalStorageDataSource.saveRefreshToken(token);
  }

  Future<void> clearToken() async {
    await _authLocalStorageDataSource.clearToken();
  }

  Future<String?> get getSavedToken async {
    return await _authLocalStorageDataSource.getToken();
  }
}
