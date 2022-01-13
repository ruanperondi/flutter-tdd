import 'package:flutter_fordev/data/cache/cache.dart';
import 'package:flutter_fordev/infra/cache/cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FetchSecureCacheStorage makeFetchSecureCacheStorate() {
  return LocalStorageAdapter(secureStorage: const FlutterSecureStorage());
}
