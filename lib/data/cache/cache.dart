

import 'package:movies_challenge/data/cache/cache_database_provider.dart';

class Cache {
  final CacheDatabaseProvider cache;

  Cache(this.cache);

  Stream<List<T>> fetchList<T>(String key, Function fetchFunction, Function transform) async* {
    var cachedObject = await cache.get(key);
    if (cachedObject != null) {
      if (cachedObject is List<dynamic>) {
        print('Transforming cache result $T for key $key');
        var objects = cachedObject.map<T>((obj) => transform(obj)).toList();
        yield objects;
      }
    }
    else {
      print('No objects $T in cache with key $key');
    }
    print('Fetching new $T content with key $key');
    var object = await fetchFunction();
    cache.insert(key, object);
    yield object;
  }
}
