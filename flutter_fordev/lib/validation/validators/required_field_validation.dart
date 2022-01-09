import '../protocols/protocols.dart';

class RequiredFieldValidation extends FieldValidation {
  @override
  final String field;

  RequiredFieldValidation(this.field);

  @override
  String validate(String? value) {
    if (value == null || value.isEmpty == true) {
      return 'Campo Obrigatório';
    }

    return '';
  }
}
