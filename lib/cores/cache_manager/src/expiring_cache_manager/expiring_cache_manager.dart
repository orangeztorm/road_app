import '../../../utils/__utils.dart';
import '../base_cache_manager.dart';

class ExpiringCacheManager<T> extends CacheManager<T> {
  final CacheManager _cacheManager;
  final Duration _expirationDuration;

  ExpiringCacheManager({
    required CacheManager cacheManager,
    Duration? expirationDuration,
  })  : _cacheManager = cacheManager,
        _expirationDuration = expirationDuration ?? const Duration(minutes: 1);

  @override
  Future<void> save(String key, dynamic value) async {
    await _cacheManager.save(key, value);

    LoggerHelper.log("ExpiringCacheManager: ${_cacheManager.toString()}");
    final Future future = Future.delayed(_expirationDuration);
    future.then((_) => remove(key));
  }

  @override
  Future<T?> get(String key) async {
    final value = await _cacheManager.get(key);
    if (value == null) return null;

    final now = DateTime.now();
    final expirationDate = now.add(_expirationDuration);

    if (now.isAfter(expirationDate)) return null;

    return value;
  }

  @override
  Future<void> remove(String key) async => await _cacheManager.remove(key);

  @override
  Future<void> clear() async => await _cacheManager.clear();
}
