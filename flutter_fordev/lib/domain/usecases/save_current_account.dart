import '../entity/entities.dart';

abstract class SaveCurrentAccount {
  Future<void> save(AccountEntity accountEntity);
}
