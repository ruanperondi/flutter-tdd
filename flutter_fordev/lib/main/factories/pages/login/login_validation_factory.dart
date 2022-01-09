import 'package:flutter_fordev/main/builders/validation_builder.dart';
import 'package:flutter_fordev/validation/protocols/field_validation.dart';

import '../../../../validation/validators/validators.dart';

ValidationComposite makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('email').requiredField().email().build(),
    ...ValidationBuilder.field('password').requiredField().build(),
  ];
}
