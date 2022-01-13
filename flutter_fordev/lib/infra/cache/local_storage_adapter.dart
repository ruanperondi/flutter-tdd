import 'package:flutter_fordev/domain/helpers/domain_error.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/cache/cache.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage, FetchSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({
    required this.secureStorage,
  });

  @override
  save({required String key, required String value}) {
    secureStorage.write(key: key, value: value);
  }

  @override
  Future<String> fetchSecure({required String key}) async {
    try {
      String? retorno = await secureStorage.read(key: key);

      return retorno ?? '';
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
