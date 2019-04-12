import 'package:movies_challenge/data/cache/cache_database_provider.dart';


class Cache {
  final CacheDatabaseProvider cache;

  Cache(this.cache);

  Stream<T> fetchObject<T>(String key, Function fetchFunction, Function transform) async* {
    var cachedObject = await cache.get(key);
    if (cachedObject != null) {
      print('Cache => Transforming cache result $T for key $key');
      yield transform(cachedObject);
    }
    else {
      print('Cache => No object $T in cache with key $key');
    }
    print('Cache => Fetching new $T content with key $key');
    var object = await fetchFunction();
    cache.insert(key, object);
    yield object;
  }

  Stream<List<T>> fetchList<T>(String key, Function fetchFunction, Function transform) async* {
    var cachedObject = await cache.get(key);
    if (cachedObject != null) {
      if (cachedObject is List<dynamic>) {
        print('Cache => Transforming cache result List<$T> for key $key');
        var objects = cachedObject.map<T>((obj) => transform(obj)).toList();
        yield objects;
      }
    }
    else {
      print('Cache => No objects List<$T> in cache with key $key');
    }
    print('Cache => Fetching new List<$T> content with key $key');
    var object = await fetchFunction();
    cache.insert(key, object);
    yield object;
  }
}
