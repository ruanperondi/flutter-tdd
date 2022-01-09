import 'package:flutter_fordev/main/factories/factories.dart';
import 'package:flutter_fordev/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct validations', () {
    var validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
    ]);
  });
}
