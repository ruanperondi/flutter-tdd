import 'package:flutter_fordev/validation/protocols/field_validation.dart';
import 'package:flutter_fordev/validation/validators/validators.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'validation_composite_test.mocks.dart';

@GenerateMocks([FieldValidation])
void main() {
  late MockFieldValidation validation1;
  late MockFieldValidation validation2;
  late MockFieldValidation validationOther;
  late ValidationComposite sut;

  void mockValidation(MockFieldValidation mock, {String? field, String? error}) {
    when(mock.validate(any)).thenReturn(error ?? '');
    when(mock.field).thenReturn(field ?? 'any_field');
  }

  setUp(() {
    validation1 = MockFieldValidation();
    validation2 = MockFieldValidation();
    validationOther = MockFieldValidation();

    sut = ValidationComposite([validation1, validation2, validationOther]);

    mockValidation(validation1);
    mockValidation(validation2);
    mockValidation(validationOther);
  });

  test('Should return null if all validation return null or empty', () {
    var error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, '');
  });

  test('Should return error any field is invalid', () {
    mockValidation(validation2, error: 'error_2');

    var error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error_2');
  });

  test('Should return other error only field other_field is error', () {
    mockValidation(validation1, error: 'error_1');
    mockValidation(validationOther, error: 'error_other', field: 'other_field');

    var error = sut.validate(field: 'other_field', value: 'any_value');

    expect(error, 'error_other');
  });
}
