import '../../cache/save_secure_cache_storage.dart';
import '../../../domain/entity/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalSaveCurrentAccount extends SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({
    required this.saveSecureCacheStorage,
  });

  @override
  Future<void> save(AccountEntity accountEntity) async {
    try {
      await saveSecureCacheStorage.save(key: 'token', value: accountEntity.accessToken);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
