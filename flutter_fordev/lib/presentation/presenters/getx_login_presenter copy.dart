import 'dart:async';

import 'package:get/get.dart';

import '../../ui/pages/login/login_presenter.dart';
import '../../domain/usecases/authentication.dart';
import '../../domain/helpers/helpers.dart';

import '../protocols/protocols.dart';

class GetxLoginPresenter extends LoginPresenter {
  final Validation validation;
  final Authentication authentication;

  String _email = '';
  String _password = '';

  final _emailError = RxString('');
  final _passwordError = RxString('');
  final _mainError = RxString('');
  final _isFormValid = false.obs;
  final _isLoading = false.obs;

  GetxLoginPresenter({required this.validation, required this.authentication});

  @override
  validateEmail(String email) {
    _emailError.value = validation.validate(field: 'email', value: email);
    _email = email;
    validateForm();
  }

  void validateForm() {
    _isFormValid.value = _emailError.value.isEmpty && _passwordError.value.isEmpty && _email.isNotEmpty && _password.isNotEmpty;
  }

  @override
  validatePassword(String password) {
    _passwordError.value = validation.validate(field: 'password', value: password);
    _password = password;
    validateForm();
  }

  @override
  Stream<String> get emailErrorStream => _emailError.stream;

  @override
  Stream<String> get passwordErrorStream => _passwordError.stream;

  @override
  Stream<String> get mainErrorStream => _mainError.stream;

  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  Future<void> auth() async {
    _isLoading.value = true;

    try {
      await authentication.auth(AuthenticationParams(email: _email, secret: _password));
    } on DomainError catch (error) {
      _mainError.value = error.description;
    }
    _isLoading.value = false;
  }

  @override
  void dispose() {}
}
