import 'package:faker/faker.dart';
import 'package:flutter_fordev/domain/entity/entities.dart';
import 'package:flutter_fordev/domain/usecases/load_current_account.dart';
import 'package:flutter_fordev/presentation/presenters/presenters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'getx_splash_presenter_test.mocks.dart';

@GenerateMocks([LoadCurrentAccount])
main() {
  late MockLoadCurrentAccount loadCurrentAccount;
  late GetxSplashPresenter sut;
  late AccountEntity account;

  setUp(() {
    loadCurrentAccount = MockLoadCurrentAccount();
    account = AccountEntity(faker.guid.guid());

    when(loadCurrentAccount.load()).thenAnswer((_) async => account);

    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
  });

  test('Should call LoadCurrentAccount', () {
    sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should call route login when account returned is null', () async {
    when(loadCurrentAccount.load()).thenAnswer((_) async => null);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });

  test('Should call route login when any exception was throw', () async {
    when(loadCurrentAccount.load()).thenThrow(Exception());

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });

  test('Should call route surveys when account returned is not null', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount();
  });
}
