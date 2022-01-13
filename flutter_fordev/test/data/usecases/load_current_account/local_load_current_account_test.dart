import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_fordev/data/cache/cache.dart';
import 'package:flutter_fordev/data/usecases/load_current_account/load_current_account.dart';
import 'package:flutter_fordev/domain/entity/entities.dart';
import 'package:flutter_fordev/domain/helpers/domain_error.dart';

import 'local_load_current_account_test.mocks.dart';

@GenerateMocks([FetchSecureCacheStorage])
main() {
  late MockFetchSecureCacheStorage fetchSecureCacheStorage;
  late LocalLoadCurrentAccount sut;
  late String token;

  setUp(() {
    fetchSecureCacheStorage = MockFetchSecureCacheStorage();
    token = faker.guid.guid();
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorage);

    when(fetchSecureCacheStorage.fetchSecure(key: anyNamed('key'))).thenAnswer((_) async => token);
  });

  test('Should call FetchSecureCacheStorage eith correct values', () async {
    await sut.load(durationInSeconds: 0);

    verify(fetchSecureCacheStorage.fetchSecure(key: anyNamed('key')));
  });

  test('Should return AccountEntity with correct token', () async {
    AccountEntity? entity = await sut.load(durationInSeconds: 0);

    expect(AccountEntity(token), entity);
  });

  test('Should return null AccountEntity when token does not exists on cache', () async {
    when(fetchSecureCacheStorage.fetchSecure(key: anyNamed('key'))).thenAnswer((_) async => '');

    AccountEntity? entity = await sut.load(durationInSeconds: 0);

    expect(null, entity);
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws', () {
    when(fetchSecureCacheStorage.fetchSecure(key: anyNamed('key'))).thenThrow(Exception());
    Future<void> future = sut.load(durationInSeconds: 0);

    expect(future, throwsA(DomainError.unexpected));
  });
}
