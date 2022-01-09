import 'package:test/test.dart';

import 'package:flutter_fordev/validation/protocols/protocols.dart';
import 'package:flutter_fordev/validation/validators/validators.dart';

void main() {
  late FieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return empty String if value is not empty', () {
    expect(sut.validate('any_value'), '');
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), 'Campo Obrigatório');
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), 'Campo Obrigatório');
  });
}
