import 'package:flutter_fordev/domain/usecases/load_current_account.dart';

import '../../cache/cache.dart';
import '../../../domain/entity/entities.dart';
import '../../../domain/helpers/helpers.dart';

class LocalLoadCurrentAccount extends LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  LocalLoadCurrentAccount({
    required this.fetchSecureCacheStorage,
  });

  @override
  Future<AccountEntity?> load({int durationInSeconds = 2}) async {
    try {
      String token = await fetchSecureCacheStorage.fetchSecure(key: 'token');

      return token.isEmpty ? null : AccountEntity(token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
