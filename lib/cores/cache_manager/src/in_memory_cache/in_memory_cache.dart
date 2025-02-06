import '../base_cache_manager.dart';

class InMemoryCacheManager<T> implements CacheManager<T> {
  final Map<String, T> _cache = {};

  @override
  Future<void> save(String key, T value) async {
    _cache[key] = value;
  }

  @override
  Future<T?> get(String key) async {
    return _cache[key];
  }

  @override
  Future<void> remove(String key) async => _cache.remove(key);

  @override
  Future<void> clear() async => _cache.clear();

  @override
  String toString() => _cache.toString();
}
