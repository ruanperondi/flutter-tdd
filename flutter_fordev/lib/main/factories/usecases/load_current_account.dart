import 'package:flutter_fordev/data/usecases/load_current_account/local_load_current_account.dart';

import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadCurrentAccount makeLoadCurrentAccount() {
  return LocalLoadCurrentAccount(fetchSecureCacheStorage: makeFetchSecureCacheStorate());
}
