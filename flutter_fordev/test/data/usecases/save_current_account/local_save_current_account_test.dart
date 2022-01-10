import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_fordev/domain/entity/account_entity.dart';
import 'package:flutter_fordev/domain/helpers/helpers.dart';

import 'package:flutter_fordev/data/cache/save_secure_cache_storage.dart';
import 'package:flutter_fordev/data/usecases/save_current_account/save_current_account.dart';

import 'local_save_current_account_test.mocks.dart';

@GenerateMocks([SaveSecureCacheStorage])
void main() {
  late MockSaveSecureCacheStorage saveSecureCacheStorage;
  late LocalSaveCurrentAccount sut;
  late AccountEntity accountEntity;

  setUp(() {
    saveSecureCacheStorage = MockSaveSecureCacheStorage();
    accountEntity = AccountEntity(faker.guid.guid());
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);

    when(saveSecureCacheStorage.save(key: 'token', value: accountEntity.accessToken)).thenReturn(() {});
  });

  test('Should call SaveCacheStorage eith correct values', () async {
    await sut.save(accountEntity);

    verify(saveSecureCacheStorage.save(key: 'token', value: accountEntity.accessToken));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws', () async {
    when(saveSecureCacheStorage.save(key: 'token', value: accountEntity.accessToken)).thenThrow(Exception());

    Future<void> future = sut.save(accountEntity);

    expect(future, throwsA(DomainError.unexpected));
  });
}
