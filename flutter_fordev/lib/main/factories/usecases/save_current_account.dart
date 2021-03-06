import '../../../data/usecases/save_current_account/save_current_account.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

SaveCurrentAccount makeSaveCurrentAccount() {
  return LocalSaveCurrentAccount(saveSecureCacheStorage: makeSaveSecureCacheStorate());
}
