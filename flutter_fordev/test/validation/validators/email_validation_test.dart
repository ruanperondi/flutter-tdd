import 'package:test/test.dart';

import 'package:flutter_fordev/validation/protocols/protocols.dart';
import 'package:flutter_fordev/validation/validators/validators.dart';

void main() {
  late FieldValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return empty String if email is empty', () {
    expect(sut.validate(''), '');
  });

  test('Should return empty String if email is null', () {
    expect(sut.validate(null), '');
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('ruan.c.perondi@gmail.com'), '');
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('ruan.c.perondi'), 'Campo inválido');
  });
}
