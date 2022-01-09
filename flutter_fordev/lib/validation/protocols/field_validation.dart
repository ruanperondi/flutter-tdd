import 'package:equatable/equatable.dart';

abstract class FieldValidation extends Equatable {
  String get field;

  String validate(String? value);

  @override
  List<Object?> get props => [field];
}
