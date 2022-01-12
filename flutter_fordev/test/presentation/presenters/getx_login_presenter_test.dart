import 'package:faker/faker.dart';
import 'package:flutter_fordev/domain/usecases/usecases.dart';
import 'package:flutter_fordev/presentation/presenters/getx_login_presenter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_fordev/domain/entity/account_entity.dart';
import 'package:flutter_fordev/domain/helpers/domain_error.dart';
import 'package:flutter_fordev/presentation/protocols/protocols.dart';
import 'getx_login_presenter_test.mocks.dart';

@GenerateMocks([Validation, Authentication, SaveCurrentAccount])
main() {
  late MockValidation mockValidation;
  late GetxLoginPresenter sut;
  late String email;
  late String password;
  late MockAuthentication authentication;
  late MockSaveCurrentAccount saveCurrentAccount;

  PostExpectation mockValidationCall({String? field, String? value}) =>
      when(mockValidation.validate(field: field ?? anyNamed('field'), value: value ?? anyNamed('value')));

  void mockValidationReturn({String? field, String? value, String? returnValue}) {
    mockValidationCall(field: field, value: value).thenReturn(returnValue ?? '');
  }

  setUp(() {
    authentication = MockAuthentication();
    mockValidation = MockValidation();
    saveCurrentAccount = MockSaveCurrentAccount();
    sut = GetxLoginPresenter(validation: mockValidation, authentication: authentication, saveCurrentAccount: saveCurrentAccount);
    email = faker.internet.email();
    password = faker.internet.password();
  });

  test('Should call validation with correct email', () {
    mockValidationReturn(field: 'email', value: email);

    sut.validateEmail(email);

    verify(mockValidation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit in email error if validation fails', () {
    mockValidationReturn(returnValue: 'Erro');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'Erro')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit empty string if validation succeeds', () {
    mockValidationReturn();

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call validation with correct password', () {
    mockValidationReturn(field: 'password', value: password);

    sut.validatePassword(password);

    verify(mockValidation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit in password error if validation fails', () {
    mockValidationReturn(returnValue: 'Erro');

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, 'Erro')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit empty string if validation succeeds', () {
    mockValidationReturn();

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit empty string if validation succeeds', () {
    mockValidationReturn(field: 'email', returnValue: 'erro');
    mockValidationReturn(field: 'password', returnValue: '');

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'erro')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit empty string if validation succeeds', () async {
    mockValidationReturn(field: 'email', returnValue: '');
    mockValidationReturn(field: 'password', returnValue: '');

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, '')));

    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call authentication with correct values', () async {
    mockValidationReturn(field: 'email', returnValue: '');
    mockValidationReturn(field: 'password', returnValue: '');

    when(authentication.auth(any)).thenAnswer((_) async => AccountEntity(faker.guid.guid()));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);

    await sut.auth();

    verify(authentication.auth(AuthenticationParams(email: email, secret: password))).called(1);
  });

  test('Should emit correct events on authentication success', () async {
    mockValidationReturn(field: 'email', returnValue: '');
    mockValidationReturn(field: 'password', returnValue: '');

    when(authentication.auth(any)).thenAnswer((_) async => AccountEntity(faker.guid.guid()));

    expectLater(sut.isLoadingStream, emits(true));

    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();
  });

  test('Should call SaveCurrentAccount with correct values', () async {
    mockValidationReturn(field: 'email', returnValue: '');
    mockValidationReturn(field: 'password', returnValue: '');

    var account = AccountEntity(faker.guid.guid());

    when(authentication.auth(any)).thenAnswer((_) async => account);
    when(saveCurrentAccount.save(account)).thenAnswer((_) async {});

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);

    await sut.auth();

    verify(authentication.auth(AuthenticationParams(email: email, secret: password))).called(1);
    verify(saveCurrentAccount.save(account));
  });

  test('Should change page to surveys on success', () async {
    mockValidationReturn(field: 'email', returnValue: '');
    mockValidationReturn(field: 'password', returnValue: '');

    var account = AccountEntity(faker.guid.guid());

    when(authentication.auth(any)).thenAnswer((_) async => account);
    when(saveCurrentAccount.save(account)).thenAnswer((_) async {});

    sut.validateEmail(email);
    sut.validatePassword(password);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.auth();
  });

  test('Should emit correct events on InvalidCredentialsError', () async {
    mockValidationReturn(field: 'email', returnValue: '');
    mockValidationReturn(field: 'password', returnValue: '');

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(error, 'Credenciais inválidas.')));

    when(authentication.auth(any)).thenThrow(DomainError.invalidCredentials);

    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockValidationReturn(field: 'email', returnValue: '');
    mockValidationReturn(field: 'password', returnValue: '');

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(error, 'Algo errado aconteceu. Tente novamente em breve.')));

    when(authentication.auth(any)).thenThrow(DomainError.unexpected);

    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();
  });
}
