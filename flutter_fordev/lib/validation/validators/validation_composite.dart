import '/presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';

class ValidationComposite extends Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({required String field, required String value}) {
    for (var validation in validations) {
      if (validation.field != field) {
        continue;
      }

      String error = validation.validate(value);

      if (error.isNotEmpty) {
        return error;
      }
    }

    return '';
  }
}
