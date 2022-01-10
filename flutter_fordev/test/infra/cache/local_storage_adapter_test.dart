import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_fordev/infra/cache/cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'local_storage_adapter_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late LocalStorageAdapter sut;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    sut = LocalStorageAdapter(secureStorage: mockFlutterSecureStorage);

    when(mockFlutterSecureStorage.write(key: anyNamed('key'), value: ('value')));
  });

  test('Should call save secure with correct values', () async {
    await sut.save(key: 'key', value: 'value');

    verify(mockFlutterSecureStorage.write(key: 'key', value: 'value'));
  });
}
