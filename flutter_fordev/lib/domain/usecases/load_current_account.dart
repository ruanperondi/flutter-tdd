import '../entity/entities.dart';

abstract class LoadCurrentAccount {
  Future<AccountEntity?> load({int durationInSeconds = 2});
}
