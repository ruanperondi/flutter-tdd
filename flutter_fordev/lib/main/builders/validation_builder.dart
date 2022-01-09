import '../../validation/protocols/protocols.dart';
import '../../validation/validators/validators.dart';

class ValidationBuilder {
  String fieldName;

  List<FieldValidation> _validations = [];

  ValidationBuilder._(this.fieldName);

  static ValidationBuilder field(String fieldName) {
    var builder = ValidationBuilder._(fieldName);

    return builder;
  }

  ValidationBuilder requiredField() {
    _validations.add(RequiredFieldValidation(fieldName));

    return this;
  }

  ValidationBuilder email() {
    _validations.add(EmailValidation(fieldName));

    return this;
  }

  List<FieldValidation> build() {
    return _validations;
  }
}
