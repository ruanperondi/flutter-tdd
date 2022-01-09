import 'package:flutter_fordev/validation/protocols/protocols.dart';

class EmailValidation extends FieldValidation {
  @override
  final String field;

  EmailValidation(this.field);

  @override
  String validate(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }

    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (regex.hasMatch(value)) {
      return '';
    }

    return 'Campo inválido';
  }
}
